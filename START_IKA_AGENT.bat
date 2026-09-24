@echo off
setlocal EnableExtensions EnableDelayedExpansion
title AI Review Analyst Agent (Ika Agent) - Startup Launcher
color 0A

echo ======================================================================
echo    AI REVIEW ANALYST AGENT (IKA AGENT) - ALL-IN-ONE LAUNCHER
echo    Multi-Channel E-Commerce Review Scraper and Sentiment Analyst
echo ======================================================================
echo.

set "N8N_URL=http://127.0.0.1:5678"
set "HEALTH_URL=%N8N_URL%/healthz"

:: 1. Periksa apakah n8n sudah aktif di port 5678
echo [1/4] Memeriksa status layanan n8n...
curl.exe -fsS %HEALTH_URL% >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] n8n sudah berjalan di %N8N_URL%.
    goto services_ready
)

:: 2. Deteksi metode eksekusi: Docker Desktop atau NPX
echo [2/4] Menentukan runtime n8n [Docker / Node.js]...

set "DOCKER_EXE="
if exist "%ProgramFiles%\Docker\Docker\Docker Desktop.exe" set "DOCKER_EXE=%ProgramFiles%\Docker\Docker\Docker Desktop.exe"
if exist "%LocalAppData%\Programs\DockerDesktop\Docker Desktop.exe" set "DOCKER_EXE=%LocalAppData%\Programs\DockerDesktop\Docker Desktop.exe"

where docker >nul 2>&1
if %ERRORLEVEL% EQU 0 goto use_docker
if not "!DOCKER_EXE!"=="" goto use_docker

goto use_npx

:use_docker
echo [INFO] Menggunakan runtime Docker...

docker info >nul 2>&1
if %ERRORLEVEL% EQU 0 goto docker_daemon_ready

if not "!DOCKER_EXE!"=="" (
    echo [INFO] Docker Desktop belum menyala. Memulai Docker Desktop...
    start "" "!DOCKER_EXE!"
) else (
    echo [INFO] Memulai Docker Desktop...
    start "" "docker" >nul 2>&1
)
echo Menunggu Docker daemon siap...

set /a docker_wait=0

:wait_docker_loop
set /a docker_wait+=1
if %docker_wait% GTR 45 goto docker_timeout
ping -n 3 127.0.0.1 >nul
docker info >nul 2>&1
if %ERRORLEVEL% EQU 0 goto docker_daemon_ready
echo Sedang menghubungkan ke Docker daemon [percobaan %docker_wait%/45]...
goto wait_docker_loop

:docker_timeout
echo [WARN] Docker tidak merespons dalam 90 detik. Beralih ke npx...
goto use_npx

:docker_daemon_ready
echo [OK] Docker daemon berhasil terhubung.

docker inspect n8n >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [INFO] Memulai container n8n yang sudah ada...
    docker start n8n >nul 2>&1
    goto wait_health
)

echo [INFO] Container n8n belum ada. Membuat container n8n baru...
docker run -d --name n8n -p 5678:5678 -e GENERIC_TIMEZONE=Asia/Jakarta -e TZ=Asia/Jakarta -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n:latest >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Gagal membuat container n8n Docker. Beralih ke npx...
    goto use_npx
)
goto wait_health

:use_npx
echo [INFO] Memeriksa runtime Node.js / NPX...
where node >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Docker dan Node.js tidak ditemukan di sistem.
    echo Silakan install Docker Desktop atau Node.js LTS untuk menjalankan n8n.
    pause
    exit /b 1
)

echo [INFO] Menjalankan n8n melalui npx di jendela terpisah...
start "n8n Workflow Engine" cmd /c "npx -y n8n"
goto wait_health

:wait_health
echo.
echo [3/4] Menunggu layanan n8n siap di %N8N_URL%...
set /a health_attempts=0

:health_loop
set /a health_attempts+=1
if %health_attempts% GTR 40 goto health_timeout

curl.exe -fsS %HEALTH_URL% >nul 2>&1
if %ERRORLEVEL% EQU 0 goto services_ready

timeout /t 3 /nobreak >nul
goto health_loop

:health_timeout
echo [ERROR] n8n belum siap setelah batas waktu.
echo Periksa konsol n8n atau log container untuk rincian error.
pause
exit /b 1

:services_ready
echo [OK] Layanan n8n aktif dan lulus health check.

:: 4. Buka n8n di peramban default
echo.
echo [4/4] Membuka dashboard n8n di peramban...
start "" "%N8N_URL%"

echo.
echo ======================================================================
echo    AI REVIEW ANALYST AGENT (IKA AGENT) BERHASIL BERJALAN
echo ======================================================================
echo.
echo  File Workflow : ai-review-analyst-agent.json
echo  Dashboard UI  : %N8N_URL%
echo.
echo  Langkah Penggunaan di n8n:
echo   1. Buka menu Workflows -^> Add Workflow -^> Import from File
echo   2. Pilih berkas "ai-review-analyst-agent.json" dari folder ini
echo   3. Atur kredensial berikut:
echo      - Telegram Bot Token di node "Cek Inbox Telegram Bot"
echo      - Apify API Token di node Scraper Shopee
echo      - Google Gemini API Key di node "Gemini 3.5 Flash Lite"
echo   4. Aktifkan workflow (Toggle Active ON)
echo.
echo  Jendela ini boleh Anda tutup sekarang.
echo ======================================================================
timeout /t 8 >nul 2>&1
endlocal
