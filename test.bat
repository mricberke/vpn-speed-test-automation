@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

where speedtest >nul 2>&1
if errorlevel 1 (
    if not exist "speedtest.exe" (
        echo [ERROR] speedtest CLI not found.
        echo Please download it from https://www.speedtest.net/apps/cli and place it in this folder.
        pause
        exit /b 1
    )
)

echo.
echo Which protocol are you testing?
echo   1^) Base (No VPN)
echo   2^) OpenVPN UDP
echo   3^) OpenVPN TCP
echo   4^) WireGuard
echo   5^) Enter custom label
echo.
set /p secim="Selection (1-5): "

if "%secim%"=="1" set "PROTOKOL=Base"
if "%secim%"=="2" set "PROTOKOL=OpenVPN-UDP"
if "%secim%"=="3" set "PROTOKOL=OpenVPN-TCP"
if "%secim%"=="4" set "PROTOKOL=WireGuard"
if "%secim%"=="5" set /p PROTOKOL="Enter label: "

if "%PROTOKOL%"=="" (
    echo [ERROR] Invalid selection.
    pause
    exit /b 1
)

set "DOSYA=speedtest_results.csv"
set "PS=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

if not exist "%DOSYA%" (
    echo Protocol;Test_No;Date_Time;Idle_Ping_ms;Jitter_ms;Download_Mbps;DL_Latency_ms;Upload_Mbps;UL_Latency_ms;Packet_Loss;Server;ISP;Result_URL>"%DOSYA%"
)

echo.
echo ============================================
echo  Protocol: %PROTOKOL%
echo  6 tests will be run, 5 minutes apart each
echo ============================================
echo.

for /l %%i in (1,1,6) do (
    echo [%%i/6] Running test... (!date! !time:~0,8!^)

    speedtest --format=json --accept-license --accept-gdpr > son_test.json 2>nul

    for /f "delims=" %%v in ('"%PS%" -NoProfile -ExecutionPolicy Bypass -File parse.ps1') do set "SONUC=%%v"

    for /f "tokens=1-10 delims=#" %%a in ("!SONUC!") do (
        set "IDLE=%%a"
        set "JIT=%%b"
        set "DL=%%c"
        set "DLL=%%d"
        set "UL=%%e"
        set "ULL=%%f"
        set "PL=%%g"
        set "SRV=%%h"
        set "ISP=%%i"
        set "URL=%%j"
    )

    set "ZAMAN=!date! !time:~0,8!"

    echo !PROTOKOL!;%%i;!ZAMAN!;!IDLE!;!JIT!;!DL!;!DLL!;!UL!;!ULL!;!PL!;!SRV!;!ISP!;!URL!>>"%DOSYA%"

    echo     Ping: !IDLE! ms  Jitter: !JIT! ms  Download: !DL! Mbps  Upload: !UL! Mbps  Loss: !PL!
    echo     Saved to: %DOSYA%
    echo.

    if %%i lss 6 (
        echo     Waiting 5 minutes for the next test...
        timeout /t 300 /nobreak >nul
        echo.
    )
)

del son_test.json >nul 2>&1

echo ============================================
echo  All tests completed! (%PROTOKOL%^)
echo  Results: %DOSYA%
echo ============================================
echo.
echo You can close this window.
pause >nul