@echo off
echo ========================================
echo Login API Status Monitor
echo ========================================
echo.

echo Checking if API is running...
curl -s http://localhost:8081/api/health > nul 2>&1
if %errorlevel% equ 0 (
    echo [✅] API is RUNNING and HEALTHY
    echo.
    curl -s http://localhost:8081/api/health
) else (
    echo [❌] API is DOWN or UNHEALTHY
    echo.
    echo Starting API...
    call mvn spring-boot:run
)

echo.
echo Press Ctrl+C to stop monitoring
echo.

:loop
timeout /t 30 > nul
goto loop
