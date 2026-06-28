-- Snappy database schema
-- Run this after connecting to your RDS MySQL instance:
--   mysql -u admin -h <your-rds-endpoint> -p snappy < schema.sql

CREATE TABLE IF NOT EXISTS songs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist VARCHAR(255) NOT NULL,
    emotion VARCHAR(50) NOT NULL,        -- HAPPY, SAD, CALM, ANGRY
    language VARCHAR(50) NOT NULL,       -- English, Korean, Brazilian
    spotify_track_id VARCHAR(50),        -- optional: Spotify's unique track ID
    album_art_url VARCHAR(500),          -- optional: album cover image URL
    preview_url VARCHAR(500),            -- optional: 30-second preview clip
    spotify_url VARCHAR(500),            -- link to search/open in Spotify
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Speeds up the most common query: "give me songs for this emotion + language"
CREATE INDEX idx_emotion_language ON songs(emotion, language);

-- Optional: track recommendation history so we can avoid repeating
-- the same song to the same session right away
CREATE TABLE IF NOT EXISTS recommendation_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    session_id VARCHAR(100) NOT NULL,
    song_id INT NOT NULL,
    emotion VARCHAR(50) NOT NULL,
    recommended_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (song_id) REFERENCES songs(id)
);
