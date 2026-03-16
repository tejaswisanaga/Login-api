@echo off
echo ================================================
echo LOGIN API - PUBLIC ACCESS SETUP
echo ================================================
echo.

REM Check for admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Administrator privileges required!
    echo Please right-click and select "Run as administrator"
    echo.
    pause
    exit /b 1
)

echo Running with Administrator privileges
echo.

REM Configure Windows Firewall
echo Step 1: Configuring Windows Firewall...
echo.

REM Delete existing rules
netsh advfirewall firewall delete rule name="Login API - Port 8081" >nul 2>&1
netsh advfirewall firewall delete rule name="Login API - Java Application" >nul 2>&1

REM Create inbound rule for port 8081
netsh advfirewall firewall add rule name="Login API - Port 8081" dir=in action=allow protocol=tcp localport=8081 enable=yes >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Inbound rule for port 8081 created
) else (
    echo [FAIL] Failed to create inbound rule
)

REM Create outbound rule for port 8081
netsh advfirewall firewall add rule name="Login API - Port 8081 Outbound" dir=out action=allow protocol=tcp localport=8081 enable=yes >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Outbound rule for port 8081 created
) else (
    echo [FAIL] Failed to create outbound rule
)

echo.
echo Step 2: Getting your IP address...
echo.

REM Get IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
    set IP=%%a
    goto :showip
)
:showip
set IP=%IP: =%
echo Your Local IP Address: %IP%
echo Other devices can access: http://%IP%:8081
echo.

echo Step 3: Starting Login API...
echo.

cd /d C:\Users\tejas\CascadeProjects\login-api

echo Starting Spring Boot Application on port 8081...
echo Application will be available at:
echo   - Local: http://localhost:8081
echo   - Network: http://%IP%:8081
echo.
echo Available Endpoints:
echo   GET  http://%IP%:8081/api/health
echo   GET  http://%IP%:8081/ping
echo   POST http://%IP%:8081/api/auth/register
echo   POST http://%IP%:8081/api/auth/login
echo.
echo IMPORTANT: Keep this window open to keep the API running!
echo Press Ctrl+C to stop the server
echo.
echo ================================================
echo.

mvn spring-boot:run

echo.
echo Server stopped. Press any key to close this window...
pause > nul
