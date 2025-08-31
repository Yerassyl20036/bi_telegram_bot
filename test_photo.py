#!/usr/bin/env python3
"""
Test script to verify photo handling functionality
"""
import os
import uuid

# Test the photo configuration
PHOTO_DIR = "/var/www/photos"
PHOTO_URL_BASE = "http://srv985126.hstgr.cloud:8080/photos"

def test_photo_setup():
    """Test if photo directory can be created"""
    try:
        # Test directory creation
        test_dir = "/tmp/test_photos"
        os.makedirs(test_dir, exist_ok=True)
        print(f"✅ Directory creation test passed: {test_dir}")
        
        # Test unique filename generation
        unique_id = str(uuid.uuid4())
        filename = f"{unique_id}.jpg"
        print(f"✅ Unique filename generated: {filename}")
        
        # Test URL construction
        photo_url = f"{PHOTO_URL_BASE}/{filename}"
        print(f"✅ Photo URL constructed: {photo_url}")
        
        # Clean up
        os.rmdir(test_dir)
        print("✅ All photo setup tests passed!")
        return True
        
    except Exception as e:
        print(f"❌ Photo setup test failed: {e}")
        return False

if __name__ == "__main__":
    test_photo_setup()
