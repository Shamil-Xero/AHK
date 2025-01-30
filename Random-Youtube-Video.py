import random
import subprocess
from yt_dlp import YoutubeDL
import os

def open_random_video(playlist_url):
    # Options for yt_dlp to extract playlist info
    ydl_opts = {
        'quiet': True,
        'extract_flat': True,  # Extract metadata without downloading
    }

    try:
        with YoutubeDL(ydl_opts) as ydl:
            # Extract playlist information
            playlist_info = ydl.extract_info(playlist_url, download=False)

            # Get the video URLs from the playlist entries
            video_urls = [entry['url'] for entry in playlist_info['entries']]

            if not video_urls:
                print("No videos found in the playlist.")
                return

            # Pick a random video URL
            random_video = random.choice(video_urls)

            # Open the video using the default video player (e.g., VLC) or web browser
            print(f"Opening video: {random_video}")
            subprocess.run(["xdg-open" if os.name == "posix" else "start", random_video], shell=True)

    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    # Replace with your playlist URL
    playlist_url = "https://www.youtube.com/playlist?list=PLb-MR2Hfk3tlmemTNdCG_K4QiTehgJAr9"
    print(f"Fetching video...")
    open_random_video(playlist_url)