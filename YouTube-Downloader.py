import sys
import yt_dlp

def download_video(video_url):
    ydl_opts = {
        'outtmpl': '%(title)s.%(ext)s',  # Save as video title
        'format': 'bestvideo[height<=1440]+bestaudio/best',  # Best quality up to 1440p
        'merge_output_format': 'mp4',  # Ensure MP4 output if merging
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([video_url])

if __name__ == "__main__":
    if len(sys.argv) < 2:
        # print("Usage: python download_video.py <video_url>")
        sys.exit(1)

    video_url = sys.argv[1]  # Get URL from command line
    download_video(video_url)
