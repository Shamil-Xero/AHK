import random
import webbrowser
from pytube import Playlist, YouTube

# Replace with the URL of your 'Watch Later' playlist
WATCH_LATER_PLAYLIST_URL = "https://www.youtube.com/playlist?list=PLb-MR2Hfk3tlmemTNdCG_K4QiTehgJAr9"

def get_random_video_from_playlist(playlist_url):
    try:
        playlist = Playlist(playlist_url)
        videos = playlist.video_urls

        if not videos:
            print("The playlist is empty or inaccessible.")
            return None

        random_video_url = random.choice(videos)
        return random_video_url

    except Exception as e:
        print(f"An error occurred: {e}")
        return None

def main():
    print("Fetching a random video from your 'Watch Later' playlist...")
    video_url = get_random_video_from_playlist(WATCH_LATER_PLAYLIST_URL)

    if video_url:
        # print(f"Random video selected: {video_url}")
        # action = input("What would you like to do? Type 'download' to download or 'play' to play in your browser: ").strip().lower()

        # if action == 'download':
        #     try:
        #         yt = YouTube(video_url)
        #         print(f"Downloading: {yt.title}")
        #         stream = yt.streams.get_by_itag(137)
        #         stream.download()
        #         print(f"Download completed: {yt.title}")
        #     except Exception as e:
        #         print(f"An error occurred while downloading: {e}")

        # elif action == 'play':
        #     print("Opening video in your default browser...")
        webbrowser.open(video_url)

        # else:
        #     print("Invalid action. Please type 'download' or 'play'.")
    else:
        print("No video found to process.")

if __name__ == "__main__":
    main()
