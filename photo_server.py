#!/usr/bin/env python3
"""
Simple HTTP server to serve photos uploaded by the Telegram bot
"""

import os
import sys
from http.server import HTTPServer, SimpleHTTPRequestHandler
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Configuration from environment
PHOTO_DIR = os.getenv("PHOTO_DIR", "./photos")
PORT = int(os.getenv("PHOTO_SERVER_PORT", "8080"))

class PhotoHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=PHOTO_DIR, **kwargs)

    def end_headers(self):
        # Add CORS headers
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

    def do_OPTIONS(self):
        # Handle preflight requests
        self.send_response(200)
        self.end_headers()

def main():
    # Create photo directory if it doesn't exist
    os.makedirs(PHOTO_DIR, exist_ok=True)
    
    try:
        with HTTPServer(("", PORT), PhotoHandler) as httpd:
            print(f"📸 Photo server running at http://0.0.0.0:{PORT}/photos/")
            print(f"📁 Serving files from: {PHOTO_DIR}")
            print("Press Ctrl+C to stop the server")
            httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n⏹️  Server stopped by user")
    except PermissionError:
        print(f"❌ Permission denied to bind to port {PORT}")
        print("Try using a different port or running with sudo")
        sys.exit(1)
    except OSError as e:
        if e.errno == 48:  # Address already in use
            print(f"❌ Port {PORT} is already in use")
            print("Try using a different port or stop the existing server")
        else:
            print(f"❌ Error starting server: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
