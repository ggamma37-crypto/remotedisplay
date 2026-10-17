@echo off
setlocal
set "RD_FPS_DIAG_LOG=1"
set "RD_FPS_DIAG_CAP=30"
if not exist "%~dp0remotedisplay.exe" (
    echo ERROR: remotedisplay.exe was not found next to this script.
    echo Copy the contents of this diagnostic package into a COPY of your v1.0.16 portable folder.
    pause
    exit /b 1
)
echo Starting Remote Display in FORCE30 diagnostic mode.
echo IMPORTANT: This requests a 30 FPS ceiling only. Host QoS may cap FPS lower.
echo Stop the session if delay or stutter becomes substantially worse.
echo Close any existing Remote Display instance before starting.
start "" "%~dp0remotedisplay.exe"
