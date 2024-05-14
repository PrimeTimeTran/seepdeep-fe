import http.server
import json

class JSONHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        with open('prompts.json', 'r') as file:
            data = json.load(file)
        self.wfile.write(json.dumps(data).encode())

def run(server_class=http.server.HTTPServer, handler_class=JSONHandler, port=8080):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting server on port {port}...')
    httpd.serve_forever()

if __name__ == '__main__':
    run()
