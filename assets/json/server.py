from flask import Flask, request, jsonify
from flask_cors import CORS
import os

import json

app = Flask(__name__)
CORS(app)
app.config['TEMPLATES_AUTO_RELOAD'] = True
app.config['DEBUG'] = True
current_dir = os.path.dirname(os.path.abspath(__file__))
files_in_current_dir = [os.path.join(current_dir, filename) for filename in os.listdir(current_dir)]
extra_files = files_in_current_dir
base_dir = os.path.dirname(os.path.abspath(__file__))


@app.route('/')
def get_data():
    category = request.args.get('category', '')

    if category:
        # Construct the absolute path to the directory containing the JSON files
        json_dir = os.path.join(base_dir, 'math')
        # filename = f"{category}.json"
        filename = f"test.json"
        file_path = os.path.join(json_dir, filename)

        try:
            with open(file_path, 'r') as file:
                data = json.load(file)
            return jsonify(data), 200
        except FileNotFoundError:
            return "File not found", 404
    else:
        return "Bad request: Missing category parameter", 400

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, extra_files=extra_files)

