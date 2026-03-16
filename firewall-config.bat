@echo off
echo ========================================
echo Login API Firewall Configuration
echo ========================================
echo.

echo Checking for Administrator privileges...
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: This script requires Administrator privileges.
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

echo.
echo Creating firewall rule for Login API port 8081...
echo.

REM Delete existing rule if it exists
netsh advfirewall firewall delete rule name="Login API Port 8081" >nul 2>&1

REM Create new inbound rule
netsh advfirewall firewall add rule name="Login API Port 8081" dir=in action=allow protocol=tcp localport=8081 >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Inbound rule created successfully
) else (
    echo [✗] Failed to create inbound rule
)

REM Create new outbound rule
netsh advfirewall firewall add rule name="Login API Port 8081 Outbound" dir=out action=allow protocol=tcp localport=8081 >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Outbound rule created successfully
) else (
    echo [✗] Failed to create outbound rule
)

REM Allow Java through firewall
netsh advfirewall firewall add rule name="Java Login API" dir=in action=allow program="C:\Program Files\Eclipse Adoptium\jdk-21.0.7.6-hotspot\bin\java.exe" enable=yes >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Java firewall rule created successfully
) else (
    echo [✗] Failed to create Java firewall rule
)

echo.
echo ========================================
echo Firewall Configuration Complete!
echo ========================================
echo.
echo Your Login API should now be accessible from other devices.
echo.
echo Test URLs:
echo - Local: http://localhost:8081/ping
echo - Network: http://%computername%:8081/ping
echo.
pause
