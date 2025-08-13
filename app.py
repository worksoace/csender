from flask import Flask, request, send_from_directory, render_template
import os
from collections import defaultdict

app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)  # Ensure uploads folder exists
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def get_unique_filename(filename):
    """Generate a unique filename if the file already exists"""
    base, ext = os.path.splitext(filename)
    counter = 1
    new_filename = filename
    
    while os.path.exists(os.path.join(app.config['UPLOAD_FOLDER'], new_filename)):
        new_filename = f"{base}_{counter}{ext}"
        counter += 1
    
    return new_filename

@app.route('/')
def index():
    """Display files sorted by date and grouped by type"""
    files = os.listdir(app.config['UPLOAD_FOLDER'])

    # Get file details (name, extension, and modification time)
    file_details = []
    for file in files:
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], file)
        file_ext = os.path.splitext(file)[1].lower() or "Other"
        file_details.append((file, file_ext, os.path.getmtime(file_path)))  # Store name, type, and timestamp

    # Sort files by date (newest first)
    file_details.sort(key=lambda x: x[2], reverse=True)

    # Group by file type
    grouped_files = defaultdict(list)
    for file_name, file_ext, _ in file_details:
        grouped_files[file_ext].append(file_name)

    return render_template('index.html', grouped_files=grouped_files)

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'files' not in request.files:
        return "No files part", 400

    files = request.files.getlist('files')
    if not files or all(file.filename == '' for file in files):
        return "No selected files", 400

    for file in files:
        if file.filename == '':
            continue  # Skip empty file inputs
        filename = get_unique_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

    return "Files uploaded successfully"

@app.route('/download/<filename>')
def download_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename, as_attachment=True)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
