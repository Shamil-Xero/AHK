import tkinter as tk
from tkinter import ttk, filedialog, messagebox
import yt_dlp
import os
import threading

class YoutubeDownloader:
    def __init__(self, root):
        self.root = root
        self.root.title("YouTube Video Downloader")
        self.root.geometry("600x400")
        self.root.configure(padx=20, pady=20)

        # URL Entry
        tk.Label(root, text="YouTube URL:").pack(anchor="w")
        self.url_entry = tk.Entry(root, width=70)
        self.url_entry.pack(pady=(0, 10))

        # Save Location
        tk.Label(root, text="Save Location:").pack(anchor="w")
        self.location_frame = tk.Frame(root)
        self.location_frame.pack(fill="x", pady=(0, 10))
        
        self.location_entry = tk.Entry(self.location_frame, width=55)
        self.location_entry.pack(side="left", padx=(0, 5))
        
        self.browse_btn = tk.Button(self.location_frame, text="Browse", command=self.browse_location)
        self.browse_btn.pack(side="left")

        # Quality Selection
        tk.Label(root, text="Video Quality:").pack(anchor="w")
        self.quality_var = tk.StringVar(value="best")
        qualities = ["best", "1080p", "720p", "480p", "360p"]
        self.quality_combo = ttk.Combobox(root, textvariable=self.quality_var, values=qualities)
        self.quality_combo.pack(pady=(0, 10))

        # Format Selection
        tk.Label(root, text="Format:").pack(anchor="w")
        self.format_var = tk.StringVar(value="mp4")
        formats = ["mp4", "mkv", "webm"]
        self.format_combo = ttk.Combobox(root, textvariable=self.format_var, values=formats)
        self.format_combo.pack(pady=(0, 10))

        # Progress Bar
        self.progress_var = tk.DoubleVar()
        self.progress_bar = ttk.Progressbar(root, variable=self.progress_var, maximum=100)
        self.progress_bar.pack(fill="x", pady=10)

        # Status Label
        self.status_label = tk.Label(root, text="Ready")
        self.status_label.pack()

        # Download Button
        self.download_btn = tk.Button(root, text="Download", command=self.start_download)
        self.download_btn.pack(pady=10)

    def browse_location(self):
        directory = filedialog.askdirectory()
        if directory:
            self.location_entry.delete(0, tk.END)
            self.location_entry.insert(0, directory)

    def update_progress(self, d):
        if d['status'] == 'downloading':
            try:
                progress = float(d['_percent_str'].replace('%', ''))
                self.progress_var.set(progress)
                self.status_label.config(text=f"Downloading... {progress:.1f}%")
                self.root.update_idletasks()
            except:
                pass

    def download_video(self):
        url = self.url_entry.get()
        save_path = self.location_entry.get()
        quality = self.quality_var.get()
        format_type = self.format_var.get()

        if not url or not save_path:
            messagebox.showerror("Error", "Please fill in all fields")
            return

        try:
            ydl_opts = {
                'format': f'bestvideo[height<={quality[:-1]}][ext={format_type}]+bestaudio/best[height<={quality[:-1]}]'
                if quality != 'best' else 'best',
                'outtmpl': os.path.join(save_path, '%(title)s.%(ext)s'),
                'progress_hooks': [self.update_progress],
            }

            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                self.download_btn.config(state="disabled")
                ydl.download([url])
                self.status_label.config(text="Download Complete!")
                messagebox.showinfo("Success", "Video downloaded successfully!")
                self.progress_var.set(0)
                self.download_btn.config(state="normal")

        except Exception as e:
            messagebox.showerror("Error", f"An error occurred: {str(e)}")
            self.status_label.config(text="Download Failed!")
            self.download_btn.config(state="normal")

    def start_download(self):
        # Start download in a separate thread to prevent GUI freezing
        download_thread = threading.Thread(target=self.download_video)
        download_thread.start()

if __name__ == "__main__":
    root = tk.Tk()
    app = YoutubeDownloader(root)
    root.mainloop()