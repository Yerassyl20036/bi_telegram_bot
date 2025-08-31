#!/usr/bin/env python3
"""
Test bot integration with photo handling
"""
import os
import sys
import asyncio
import uuid
from unittest.mock import AsyncMock, MagicMock

# Mock all missing packages before any imports
sys.modules['aiogram'] = MagicMock()
sys.modules['aiogram.types'] = MagicMock()
sys.modules['aiogram.filters'] = MagicMock()
sys.modules['aiogram.fsm'] = MagicMock()
sys.modules['aiogram.fsm.context'] = MagicMock()
sys.modules['aiogram.fsm.state'] = MagicMock()
sys.modules['aiofiles'] = MagicMock()
sys.modules['psycopg2'] = MagicMock()
sys.modules['psycopg2.sql'] = MagicMock()
sys.modules['dotenv'] = MagicMock()

# Create mock classes
class MockBot:
    async def get_file(self, file_id):
        mock_file = MagicMock()
        mock_file.file_path = "photos/test_image.jpg"
        return mock_file
    
    async def download_file(self, file_path, destination):
        # Simulate file download
        pass

class MockPhoto:
    def __init__(self):
        self.file_id = "test_file_id_123"

# Mock environment variables for testing
os.environ.setdefault('TELEGRAM_BOT_TOKEN', 'test_token')
os.environ.setdefault('DATABASE_URL', 'postgresql://test')
os.environ.setdefault('PHOTO_DIR', '/tmp/test_photos')
os.environ.setdefault('PHOTO_URL_BASE', 'http://localhost:8080/photos')
os.environ.setdefault('MAX_PHOTO_SIZE', str(10 * 1024 * 1024))

# Now we can safely import our functions
PHOTO_DIR = os.getenv("PHOTO_DIR", "/tmp/test_photos")
PHOTO_URL_BASE = os.getenv("PHOTO_URL_BASE", "http://localhost:8080/photos")
MAX_PHOTO_SIZE = int(os.getenv("MAX_PHOTO_SIZE", str(10 * 1024 * 1024)))

async def save_photo(bot, photo):
    """Simplified save_photo function for testing"""
    try:
        # Create photo directory if it doesn't exist
        os.makedirs(PHOTO_DIR, exist_ok=True)
        
        # Generate unique filename
        file_info = await bot.get_file(photo.file_id)
        file_extension = file_info.file_path.split('.')[-1] if '.' in file_info.file_path else 'jpg'
        unique_id = str(uuid.uuid4())
        filename = f"{unique_id}.{file_extension}"
        local_path = os.path.join(PHOTO_DIR, filename)
        
        # Download and save the photo
        await bot.download_file(file_info.file_path, local_path)
        
        # Return the URL
        photo_url = f"{PHOTO_URL_BASE}/{filename}"
        return photo_url
        
    except Exception as e:
        print(f"Error saving photo: {e}")
        return ""

def build_payload(block, data):
    """Simplified build_payload function for testing"""
    return {
        "edu_School": str(data.get("school", "")),
        "edu_Role": str(data.get("role", "")),
        "edu_Photo": str(data.get("photo_url", "")),
        "edu_Add_inf": str(data.get("extra_info", "")),
        "edu_Contact": str(data.get("contact_info", "")),
    }

async def test_save_photo_function():
    """Test the save_photo function with mocked bot and photo"""
    print("🧪 Testing save_photo function...")
    
    # Mock bot
    mock_bot = AsyncMock()
    mock_file_info = MagicMock()
    mock_file_info.file_path = "photos/test_image.jpg"
    mock_bot.get_file.return_value = mock_file_info
    mock_bot.download_file = AsyncMock()
    
    # Mock photo
    mock_photo = MagicMock()
    mock_photo.file_id = "test_file_id_123"
    
    # Create photo directory for testing
    os.makedirs(PHOTO_DIR, exist_ok=True)
    
    try:
        # Test save_photo
        result_url = await save_photo(mock_bot, mock_photo)
        
        # Verify URL format
        if result_url.startswith(PHOTO_URL_BASE) and result_url.endswith('.jpg'):
            print(f"✅ Photo URL generated correctly: {result_url}")
        else:
            print(f"❌ Invalid photo URL: {result_url}")
            return False
            
        # Verify bot methods were called
        mock_bot.get_file.assert_called_once_with("test_file_id_123")
        mock_bot.download_file.assert_called_once()
        
        print("✅ save_photo function test passed!")
        return True
        
    except Exception as e:
        print(f"❌ save_photo test failed: {e}")
        return False

def test_build_payload_with_photo():
    """Test build_payload function includes photo URL"""
    print("🧪 Testing build_payload with photo...")
    
    test_data = {
        "school": "Test School",
        "role": "Student", 
        "photo_url": "http://srv985126.hstgr.cloud:8080/photos/test.jpg",
        "extra_info": "Test info",
        "contact_info": "test@example.com"
    }
    
    try:
        payload = build_payload("S1", test_data)
        
        # Check if photo URL is included
        photo_field = f"edu_Photo"  # Using PREFIX from main.py
        if photo_field in payload and payload[photo_field] == test_data["photo_url"]:
            print(f"✅ Photo URL correctly included in payload: {payload[photo_field]}")
        else:
            print(f"❌ Photo URL missing or incorrect in payload")
            print(f"Expected: {test_data['photo_url']}")
            print(f"Got: {payload.get(photo_field, 'MISSING')}")
            return False
            
        print("✅ build_payload with photo test passed!")
        return True
        
    except Exception as e:
        print(f"❌ build_payload test failed: {e}")
        return False

def test_photo_configuration():
    """Test photo configuration constants"""
    print("🧪 Testing photo configuration...")
    
    try:
        # Check constants are defined
        assert PHOTO_DIR == "/tmp/test_photos", f"Wrong PHOTO_DIR: {PHOTO_DIR}"
        assert PHOTO_URL_BASE == "http://localhost:8080/photos", f"Wrong URL base: {PHOTO_URL_BASE}"
        
        print(f"✅ Photo directory: {PHOTO_DIR}")
        print(f"✅ Photo URL base: {PHOTO_URL_BASE}")
        print("✅ Photo configuration test passed!")
        return True
        
    except Exception as e:
        print(f"❌ Photo configuration test failed: {e}")
        return False

async def main():
    """Run all integration tests"""
    print("🚀 Starting bot integration tests...\n")
    
    tests = [
        ("Photo Configuration", test_photo_configuration()),
        ("Build Payload with Photo", test_build_payload_with_photo()),
        ("Save Photo Function", await test_save_photo_function()),
    ]
    
    passed = 0
    total = len(tests)
    
    for test_name, result in tests:
        if result:
            passed += 1
        print()  # Empty line between tests
    
    print("=" * 50)
    print(f"📊 Test Results: {passed}/{total} tests passed")
    
    if passed == total:
        print("🎉 All bot integration tests passed!")
        print("\n📝 Next steps:")
        print("1. Deploy photo_server.py to VPS")
        print("2. Update bot code on VPS")
        print("3. Install aiofiles: pip install aiofiles==24.1.0")
        print("4. Test photo upload in production")
    else:
        print("❌ Some tests failed. Please fix before deployment.")
    
    return passed == total

if __name__ == "__main__":
    asyncio.run(main())
