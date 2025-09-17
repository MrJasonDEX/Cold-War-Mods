@echo off
setlocal

:: === CONFIGURATION ===
set REPO_URL=https://github.com/MrJasonDEX/Cold-War-Mods.git
set TARGET_DIR=C:\Cold-War-Mods

:: TEMP folder for cloning
set TEMP_DIR=%TEMP%\ColdWarModsTemp

echo.
echo ======================================
echo  Cold War Mods Updater
echo  Repo: %REPO_URL%
echo  Target: %TARGET_DIR%
echo ======================================
echo.

:: If target directory doesn't exist, create it
if not exist "%TARGET_DIR%" (
    echo Creating target folder "%TARGET_DIR%"...
    mkdir "%TARGET_DIR%"
)

:: Remove old temp folder if exists
if exist "%TEMP_DIR%" (
    echo Cleaning old temporary folder...
    rmdir /s /q "%TEMP_DIR%"
)

:: Clone repo fresh into temp
echo Cloning repository...
git clone --depth=1 "%REPO_URL%" "%TEMP_DIR%"
if errorlevel 1 (
    echo [ERROR] Git clone failed. Please check your internet or repo URL.
    pause
    exit /b 1
)

:: Mirror files from temp to target (exact sync, deletes extras)
echo Syncing files to target folder...
robocopy "%TEMP_DIR%" "%TARGET_DIR%" /MIR /MT:8 /NFL /NDL /NJH /NJS /NP

:: Cleanup temp
echo Cleaning up temporary files...
rmdir /s /q "%TEMP_DIR%"

echo.
echo ======================================
echo   Update complete! Cold War Mods ready
echo ======================================
pause
