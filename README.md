# csender
Basic Local file sender using flask
----------------

# Csender — Simple File Sender & Receiver (Flask)

Csender is a lightweight file sharing application built with Flask.
It allows you to upload multiple files from your browser, organizes them by file type, and lets anyone download them easily.

## Features

* Multiple file uploads at once
* Grouped by file type for better organization
* Newest files shown first
* Automatic renaming to avoid overwriting existing files
* Easy file downloads from the browser
* Works over local network (same Wi-Fi)

----------------

## Installation

```bash
git clone https://github.com/your-username/csender.git
cd csender
pip install flask
```

The `uploads` folder will be created automatically when you run the app.

----------------

## Usage

Run the server:

```bash
python app.py
```

By default:

```
http://0.0.0.0:5000
```

### Access from another device

1. Find your computer’s local IP:
   **Windows**: `ipconfig` → look for `IPv4 Address`
   **Mac/Linux**: `ifconfig` or `ip a`
2. On another device (same Wi-Fi), go to:

   ```
   http://<your-ip>:5000
   ```

----------------

## File Upload

* Go to `/`
* Select and upload multiple files
* Files with duplicate names are automatically renamed

----------------

## File Download

* Click a file in the list to download

----------------

## Project Structure

```
csender/
│── app.py
│── templates/
│   └── index.html
│── uploads/
└── README.md
```

----------------

## Tech Stack

* Backend: Python 3 + Flask
* Frontend: HTML (Jinja2)
* Storage: Local filesystem

----------------

## Notes

* For trusted/local network use only (no authentication)
* Avoid uploading sensitive files without added security

----------------
