"""
Snappy backend - Flask API + static file server
Handles: selfie upload -> Rekognition emotion detection -> song recommendation
from our own RDS-hosted music database. Also serves the built React frontend
so the whole app runs as a single Elastic Beanstalk environment.

Before running, set these environment variables (see .env.example):
    AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION
    RDS_HOST, RDS_USER, RDS_PASSWORD, RDS_DB_NAME
    S3_BUCKET_NAME
"""

import os
import uuid
from io import BytesIO

import boto3
import mysql.connector
from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS
from dotenv import load_dotenv
from PIL import Image

load_dotenv()

# "static_folder" points to the built React app (see build instructions in README)
app = Flask(__name__, static_folder="static", static_url_path="")
CORS(app)  # harmless to keep enabled even once frontend+backend share an origin

# ---------------------------------------------------------------------------
# AWS clients
# ---------------------------------------------------------------------------
rekognition = boto3.client(
    "rekognition",
    region_name=os.getenv("AWS_REGION", "us-east-1"),
)
s3 = boto3.client(
    "s3",
    region_name=os.getenv("AWS_REGION", "us-east-1"),
)
S3_BUCKET = os.getenv("S3_BUCKET_NAME")

# ---------------------------------------------------------------------------
# Rekognition returns 8 possible emotions. We only curate songs for 4
# "core" moods, so the others get folded into the closest match.
# ---------------------------------------------------------------------------
EMOTION_FALLBACK = {
    "HAPPY": "HAPPY",
    "SAD": "SAD",
    "CALM": "CALM",
    "ANGRY": "ANGRY",
    "SURPRISED": "HAPPY",
    "FEAR": "CALM",
    "CONFUSED": "CALM",
    "DISGUSTED": "ANGRY",
}


def convert_to_jpeg_bytes(image_bytes):
    """Rekognition only accepts JPEG or PNG. This re-encodes whatever
    standard format we received (JPEG, PNG, WEBP, etc.) into normalized
    JPEG bytes. Note: HEIC/HEIF (the default format on iPhones) is not
    decodable here since it requires a system library unavailable on
    this platform - the frontend asks the browser to convert HEIC to
    JPEG before upload to avoid this entirely."""
    img = Image.open(BytesIO(image_bytes))

    # Convert to RGB in case the source has an alpha channel (e.g. PNG)
    # since JPEG doesn't support transparency.
    if img.mode != "RGB":
        img = img.convert("RGB")

    output = BytesIO()
    img.save(output, format="JPEG", quality=90)
    return output.getvalue()


# ---------------------------------------------------------------------------
# Database connection helper
# ---------------------------------------------------------------------------
def get_db_connection():
    return mysql.connector.connect(
        host=os.getenv("RDS_HOST"),
        user=os.getenv("RDS_USER"),
        password=os.getenv("RDS_PASSWORD"),
        database=os.getenv("RDS_DB_NAME", "snappy"),
    )


def get_random_song(emotion, language):
    """Pull a random song matching the given emotion + language from RDS.
    Using ORDER BY RAND() so repeated requests return different songs
    rather than always the same top match."""
    mapped_emotion = EMOTION_FALLBACK.get(emotion.upper(), "CALM")

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT title, artist, album_art_url, spotify_url "
        "FROM songs WHERE emotion = %s AND language = %s "
        "ORDER BY RAND() LIMIT 1",
        (mapped_emotion, language),
    )
    song = cursor.fetchone()

    cursor.close()
    conn.close()
    return song, mapped_emotion


# ---------------------------------------------------------------------------
# API routes
# ---------------------------------------------------------------------------
@app.route("/api/analyze", methods=["POST"])
def analyze():
    """Receive a selfie + chosen language, run emotion detection, and
    return a song recommendation in that language."""
    if "image" not in request.files:
        return jsonify({"error": "No image provided"}), 400

    # Language defaults to English if the frontend doesn't specify one
    language = request.form.get("language", "English")

    image_file = request.files["image"]
    raw_bytes = image_file.read()

    # Always normalize to JPEG so iPhone HEIC uploads (and any other
    # format) work consistently with Rekognition, which only accepts
    # JPEG or PNG.
    try:
        image_bytes = convert_to_jpeg_bytes(raw_bytes)
    except Exception:
        return jsonify(
            {"error": "Could not read that image. Please try a different photo."}
        ), 400

    # Optional: store the selfie in S3 for record-keeping
    if S3_BUCKET:
        key = f"selfies/{uuid.uuid4()}.jpg"
        s3.put_object(Bucket=S3_BUCKET, Key=key, Body=image_bytes)

    # Call Rekognition to detect emotions in the image
    response = rekognition.detect_faces(
        Image={"Bytes": image_bytes},
        Attributes=["ALL"],
    )

    if not response["FaceDetails"]:
        return jsonify({"error": "No face detected. Try a clearer selfie!"}), 400

    # Take the first detected face's top emotion
    emotions = response["FaceDetails"][0]["Emotions"]
    top_emotion = max(emotions, key=lambda e: e["Confidence"])

    emotion_name = top_emotion["Type"]
    confidence = top_emotion["Confidence"]

    song, mapped_emotion = get_random_song(emotion_name, language)
    if song is None:
        return jsonify(
            {"error": f"No songs found for {mapped_emotion} in {language}"}
        ), 500

    return jsonify(
        {
            "emotion": emotion_name.lower(),
            "mappedEmotion": mapped_emotion.lower(),
            "confidence": confidence,
            "language": language,
            "songTitle": song["title"],
            "artist": song["artist"],
            "albumArt": song["album_art_url"],
            "spotifyUrl": song["spotify_url"],
        }
    )


@app.route("/api/recommend", methods=["GET"])
def recommend():
    """Get another song recommendation for an already-detected emotion."""
    emotion = request.args.get("emotion")
    language = request.args.get("language", "English")

    if not emotion:
        return jsonify({"error": "emotion query param required"}), 400

    song, mapped_emotion = get_random_song(emotion, language)
    if song is None:
        return jsonify(
            {"error": f"No songs found for {mapped_emotion} in {language}"}
        ), 500

    return jsonify(
        {
            "songTitle": song["title"],
            "artist": song["artist"],
            "albumArt": song["album_art_url"],
            "spotifyUrl": song["spotify_url"],
        }
    )


@app.route("/api/health", methods=["GET"])
def health():
    """Simple health check endpoint."""
    return jsonify({"status": "ok"})


# ---------------------------------------------------------------------------
# Serve the built React frontend for every non-API route
# ---------------------------------------------------------------------------
@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def serve_react(path):
    if path and os.path.exists(os.path.join(app.static_folder, path)):
        return send_from_directory(app.static_folder, path)
    return send_from_directory(app.static_folder, "index.html")


if __name__ == "__main__":
    app.run(debug=True, port=5001)
