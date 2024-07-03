import os
import time
import json
import http.server
from openai import OpenAI
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

key = os.environ.get("OPENAI_API_KEY")

client = OpenAI(api_key=key)

def stream_audio(text):
    audio_dir = './audios'
    os.makedirs(audio_dir, exist_ok=True)
    first_three_words = ' '.join(text.split()[:3])
    timestamp = time.strftime("%Y%m%d-%H%M%S")
    file_name = f"{timestamp}_{first_three_words}.mp3"
    audio_path = os.path.join(audio_dir, file_name)
    
    with open(audio_path, 'wb') as audio_file:
        with client.audio.speech.with_streaming_response.create(
            input=text,
            voice="alloy",
            model="tts-1",
        ) as response:
            for chunk in response.iter_bytes():
                audio_file.write(chunk)
                yield chunk

class JSONHandler(http.server.BaseHTTPRequestHandler):
    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()
    def do_POST(self):
        try:
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length).decode('utf-8')
            data = json.loads(post_data)
            text = data.get('body', '')
            self.send_response(200)
            self.send_header('Content-type', 'audio/mpeg')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()

            for chunk in stream_audio(text):
                self.wfile.write(chunk)
        except Exception as e:
            self.send_error(500, f'Internal Server Error: {str(e)}')

def run(server_class=http.server.HTTPServer, handler_class=JSONHandler, port=8080):
    global server_process
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting server on port {port}...')
    server_process = httpd
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        httpd.server_close()
        print("Server stopped.")

if __name__ == "__main__":
    run()
