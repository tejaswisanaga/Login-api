@echo off
echo ========================================
echo Login API - Ngrok Public Access Setup
echo ========================================
echo.
echo This script will create a public URL for your Login API
echo.
echo 1. Download ngrok from: https://ngrok.com/download
echo 2. Extract ngrok.exe to this folder
echo 3. Sign up at ngrok.com and get your authtoken
echo 4. Run: ngrok authtoken YOUR_TOKEN
echo 5. Then run this script
echo.
echo Starting ngrok tunnel to port 8081...
echo.
echo Your API will be available at a public URL like:
echo https://xxxx.ngrok-free.app
echo.
if exist "ngrok.exe" (
    ngrok http 8081
) else (
    echo ERROR: ngrok.exe not found!
    echo Please download ngrok from https://ngrok.com/download
    pause
)
