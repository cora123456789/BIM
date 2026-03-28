@echo off
chcp 65001 >nul
cd /d "%~dp0"
rem START_VR_SERVER v2 (HTML+GLB pruefen, py -3, --bind 127.0.0.1). Alte kurze BAT auf GitHub ersetzen.

title BIM VR – lokaler Server
echo.
echo  BIM – lokaler Webserver (Viewer + GLB)
echo  =======================================

if not exist "VR_Viewer_Web.html" (
  echo.
  echo  [FEHLER] VR_Viewer_Web.html wurde hier nicht gefunden.
  echo.
  echo  Wichtig: HTML, GLB und diese BAT-Datei muessen im GLEICHEN Ordner liegen.
  echo  Wenn Sie von GitHub laden:
  echo    - Nicht nur einzelne Dateien speichern, sondern "Code" ^> "Download ZIP"
  echo    - ZIP entpacken, dann diese BAT im ENTpackten Ordner doppelklicken.
  echo.
  pause
  exit /b 1
)

if not exist "Projekt_BIM_AUF.glb" (
  echo.
  echo  [FEHLER] Projekt_BIM_AUF.glb wurde hier nicht gefunden.
  echo  Gleicher Ordner wie diese BAT-Datei noetig.
  echo.
  pause
  exit /b 1
)

echo  Ordner: %cd%
echo.
echo  Der Browser oeffnet gleich die Viewer-Seite.
echo  Dieses Fenster OFFEN LASSEN – sonst stoppt der Server.
echo  Beenden: Strg+C  (danach Enter)
echo.

REM Browser kurz nach Serverstart oeffnen (Server laeuft im Vordergrund)
start "" cmd /c "timeout /t 2 /nobreak >nul & start http://127.0.0.1:8080/VR_Viewer_Web.html"

where py >nul 2>&1
if %errorlevel% equ 0 (
  py -3 -m http.server 8080 --bind 127.0.0.1
  goto server_end
)

where python >nul 2>&1
if %errorlevel% equ 0 (
  python -m http.server 8080 --bind 127.0.0.1
  goto server_end
)

echo  [FEHLER] Python 3 wurde nicht gefunden.
echo.
echo  Bitte installieren: https://www.python.org/downloads/
echo  Bei der Installation Haken setzen: "Add python.exe to PATH"
echo.
echo  Danach dieses Fenster schliessen und die BAT erneut starten.
echo.
echo  Oder manuell in DIESEM Ordner in PowerShell/CMD:
echo    py -3 -m http.server 8080 --bind 127.0.0.1
echo  Dann im Browser: http://127.0.0.1:8080/VR_Viewer_Web.html
echo.
pause
exit /b 1

:server_end
echo.
echo  Server beendet.
pause
