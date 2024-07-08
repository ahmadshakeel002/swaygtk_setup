import gi
import subprocess

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class VideoPlayerApp(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Video Player")
        self.set_border_width(10)
        self.set_default_size(200, 100)

        button = Gtk.Button(label="Play Video")
        button.connect("clicked", self.on_play_button_clicked)
        self.add(button)

    def on_play_button_clicked(self, widget):
        video_path = "/home/impulse/file.mp4"  # Replace with the actual path to your video
        subprocess.run(["mpv", "--fs", video_path])

def main():
    app = VideoPlayerApp()
    app.connect("destroy", Gtk.main_quit)
    app.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()
