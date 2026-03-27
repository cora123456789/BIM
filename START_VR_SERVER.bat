@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo.
echo  VR-Webserver  (HTML nicht per Doppelklick oeffnen - immer dieser Server)
echo  ============
echo  Ordner: %cd%
echo.
echo  Danach im Browser:
echo    http://localhost:8080/VR_Viewer_Web.html
echo.
echo  Fenster OFFEN LASSEN. Ende: Strg+C
echo.

python -m http.server 8080 2>nul
if errorlevel 1 py -3 -m http.server 8080 2>nul
if errorlevel 1 (
  echo Python nicht gefunden. Bitte installieren oder in diesem Ordner manuell ausfuehren:
  echo   py -3 -m http.server 8080
  echo Wenn Port belegt ist, z.B.:
  echo   py -3 -m http.server 8765
  pause
  exit /b 1
)
pause
