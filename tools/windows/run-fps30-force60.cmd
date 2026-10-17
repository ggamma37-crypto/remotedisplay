@echo off
setlocal
set "RD_FPS_DIAG_LOG=1"
set "RD_FPS_DIAG_CAP=60"
if not exist "%~dp0remotedisplay.exe" (
    echo ERROR: remotedisplay.exe was not found next to this script.
    echo Copy this script into a COPY of the Remote Display v1.0.16 portable folder.
    pause
    exit /b 1
)
echo Starting Remote Display in diagnostic requested-ceiling 60 FPS mode.
echo This bypasses only client-side auto-FPS; Mac host QoS may reduce it.
echo Stop immediately if frames queue up or input latency becomes high.
echo Close any already running Remote Display instance before starting.
start "" "%~dp0remotedisplay.exe"
