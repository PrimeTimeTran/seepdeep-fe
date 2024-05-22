from flask import Flask, request, jsonify
from flask_cors import CORS
import os

import json

app = Flask(__name__)
CORS(app)
app.config['TEMPLATES_AUTO_RELOAD'] = True
app.config['DEBUG'] = True
current_dir = os.path.dirname(os.path.abspath(__file__))

# Get a list of all files in the current directory
files_in_current_dir = [os.path.join(current_dir, filename) for filename in os.listdir(current_dir)]

# Add the files in the current directory to the extra_files list
extra_files = files_in_current_dir
@app.route('/')
def get_data():
    category = request.args.get('category', '')

    if category:
        filename = f"{category}.json"
        try:
            with open(filename, 'r') as file:
                data = json.load(file)
            return jsonify(data), 200
        except FileNotFoundError:
            return "File not found", 404
    else:
        return "Bad request: Missing category parameter", 400

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, extra_files=extra_files)

