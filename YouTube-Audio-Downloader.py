import sys
import yt_dlp

def download_audio(video_url):
    ydl_opts = {
        'format': 'bestaudio/best',  # Extract best audio
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',  # Convert to MP3
            'preferredquality': '192',  # Audio quality (bitrate)
        }],
        'outtmpl': '%(title)s.%(ext)s',  # Save as video title
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([video_url])

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python YouTube-Downloader.py <video_url>")
        sys.exit(1)

    video_url = sys.argv[1]  # Get URL from command line
    download_audio(video_url)