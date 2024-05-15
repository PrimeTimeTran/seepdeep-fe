import http.server
import os
from openai import OpenAI
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

key = os.environ.get("OPENAI_API_KEY")

client = OpenAI(
    api_key=key)

class MyFileSystemEventHandler(FileSystemEventHandler):
    def __init__(self, callback):
        self.callback = callback

    def on_modified(self, event):
        if event.src_path.endswith(".py"):
            print("File modified. Reloading...")
            self.callback()

def stream_audio():
    with client.audio.speech.with_streaming_response.create(
        model="tts-1",
        voice="alloy",
        input="Wow, thats great. Try again",
    ) as response:
        for chunk in response.iter_bytes():
            yield chunk


class JSONHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'audio/mpeg')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        try:
            for chunk in stream_audio():
                self.wfile.write(chunk)
        except BrokenPipeError:
            pass


def run(server_class=http.server.HTTPServer, handler_class=JSONHandler, port=8080):
    global server_process
    print('Running..  .')
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting server on port {port}...')
    server_process = httpd
    httpd.serve_forever()
    print("Server has been reloaded.")


def watch_and_reload():
    observer = Observer()
    observer.schedule(MyFileSystemEventHandler(run), ".", recursive=True)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()


if __name__ == '__main__':
    watch_and_reload()