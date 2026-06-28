import { useState } from 'react'
import './App.css'

// In production, the React build is served by the same Flask app, so we can
// use a relative path. For local dev (npm run dev), point to Flask directly.
const API_BASE_URL = import.meta.env.DEV ? 'http://localhost:5001' : ''

// iPhones default to capturing photos as HEIC, which AWS Rekognition can't
// read directly. The Flask backend doesn't have the system library needed
// to decode HEIC either. So instead, we use the browser itself: Safari/iOS
// already knows how to *display* HEIC photos (it's a native OS-level codec),
// so we draw the photo onto a <canvas> and re-export it as a JPEG blob before
// ever sending it to the server. This works regardless of the original format.
function convertImageFileToJpeg(file) {
  return new Promise((resolve, reject) => {
    const img = new Image()
    const objectUrl = URL.createObjectURL(file)

    img.onload = () => {
      const canvas = document.createElement('canvas')
      canvas.width = img.naturalWidth
      canvas.height = img.naturalHeight

      const ctx = canvas.getContext('2d')
      ctx.drawImage(img, 0, 0)

      canvas.toBlob(
        (blob) => {
          URL.revokeObjectURL(objectUrl)
          if (blob) {
            resolve(blob)
          } else {
            reject(new Error('Could not convert image.'))
          }
        },
        'image/jpeg',
        0.9
      )
    }

    img.onerror = () => {
      URL.revokeObjectURL(objectUrl)
      reject(new Error('Could not load that image.'))
    }

    img.src = objectUrl
  })
}

function App() {
  const [selectedBlob, setSelectedBlob] = useState(null)
  const [previewUrl, setPreviewUrl] = useState(null)
  const [language, setLanguage] = useState('English')
  const [loading, setLoading] = useState(false)
  const [result, setResult] = useState(null)
  const [error, setError] = useState(null)

  // Handle file selection from input - convert to JPEG immediately so
  // HEIC photos from iPhones are normalized before we ever touch the network
  const handleFileChange = async (e) => {
    const file = e.target.files[0]
    if (!file) return

    setResult(null)
    setError(null)

    try {
      const jpegBlob = await convertImageFileToJpeg(file)
      setSelectedBlob(jpegBlob)
      setPreviewUrl(URL.createObjectURL(jpegBlob))
    } catch (err) {
      setError('Could not read that photo. Please try a different one.')
    }
  }

  // Send the selfie + chosen language to the backend for analysis
  const handleUpload = async () => {
    if (!selectedBlob) {
      setError('Please select a photo first!')
      return
    }

    setLoading(true)
    setError(null)
    setResult(null)

    const formData = new FormData()
    formData.append('image', selectedBlob, 'selfie.jpg')
    formData.append('language', language)

    try {
      const response = await fetch(`${API_BASE_URL}/api/analyze`, {
        method: 'POST',
        body: formData,
      })

      if (!response.ok) {
        throw new Error('Something went wrong analyzing your photo.')
      }

      const data = await response.json()
      setResult(data)
    } catch (err) {
      setError(err.message || 'Upload failed. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  // Request another song recommendation for the same detected emotion
  const handleAnotherSong = async () => {
    if (!result?.mappedEmotion) return

    setLoading(true)
    setError(null)

    try {
      const response = await fetch(
        `${API_BASE_URL}/api/recommend?emotion=${result.mappedEmotion}&language=${language}`
      )
      if (!response.ok) {
        throw new Error('Could not fetch another recommendation.')
      }
      const data = await response.json()
      setResult((prev) => ({ ...prev, ...data }))
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="app-container">
      <header className="app-header">
        <h1>Snappy</h1>
        <p>Upload a selfie and we'll find the perfect song for your mood</p>
      </header>

      <div className="upload-section">
        <label htmlFor="photo-upload" className="upload-label">
          {previewUrl ? (
            <img src={previewUrl} alt="Preview" className="preview-img" />
          ) : (
            <div className="upload-placeholder">
              <span>😶‍🌫️</span>
              <p>Click to upload a selfie</p>
            </div>
          )}
        </label>
        <input
          id="photo-upload"
          type="file"
          accept="image/*"
          onChange={handleFileChange}
          hidden
        />

        <div className="language-select-wrap">
          <label htmlFor="language-select">Song language:</label>
          <select
            id="language-select"
            value={language}
            onChange={(e) => setLanguage(e.target.value)}
          >
            <option value="English">English</option>
            <option value="Korean">Korean</option>
            <option value="Brazilian">Portuguese</option>
          </select>
        </div>

        <button
          onClick={handleUpload}
          disabled={loading || !selectedBlob}
          className="analyze-btn"
        >
          {loading ? 'Analyzing...' : 'Find My Song'}
        </button>
      </div>

      {error && <div className="error-box">{error}</div>}

      {result && (
        <div className="result-section">
          <h2>Detected Mood: {result.emotion}</h2>

          <div className="song-card">
            {result.albumArt && (
              <img
                src={result.albumArt}
                alt={result.songTitle}
                className="album-art"
              />
            )}
            <div className="song-info">
              <h3>{result.songTitle}</h3>
              <p>{result.artist}</p>
              {result.spotifyUrl && (
                <a
                  href={result.spotifyUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="spotify-link"
                >
                  Listen →
                </a>
              )}
            </div>
          </div>

          <button onClick={handleAnotherSong} className="another-btn">
            Show me another song
          </button>
        </div>
      )}
    </div>
  )
}

export default App
