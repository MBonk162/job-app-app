@echo off
REM Script to create Android signing keystore

echo Creating Android signing keystore...
echo.
echo You'll be asked for:
echo   - Keystore password (remember this!)
echo   - Key alias password (can be same as keystore password)
echo   - Your name, organization, etc.
echo.

REM Get the directory where this script is located
set SCRIPT_DIR=%~dp0
set KEYSTORE_PATH=%SCRIPT_DIR%app\upload-keystore.jks

echo Keystore will be created at: %KEYSTORE_PATH%
echo.

REM Check if keytool is available
where keytool >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: keytool not found!
    echo.
    echo keytool is part of the Java JDK. Please ensure:
    echo 1. Java JDK is installed
    echo 2. JAVA_HOME is set
    echo 3. keytool is in your PATH
    echo.
    echo If you have Android Studio, keytool is usually at:
    echo "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe"
    echo.
    pause
    exit /b 1
)

REM Create the keystore
keytool -genkey -v -keystore "%KEYSTORE_PATH%" -keyalg RSA -keysize 2048 -validity 10000 -alias upload

REM Check if the file was created
if exist "%KEYSTORE_PATH%" (
    echo.
    echo ========================================
    echo SUCCESS! Keystore created at:
    echo %KEYSTORE_PATH%
    echo ========================================
    echo.
    echo IMPORTANT: Keep this file and passwords safe!
    echo You'll need them for all future app updates.
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR: Keystore file was not created!
    echo ========================================
    echo.
    echo The keytool command may have failed.
    echo Check the error messages above.
    echo.
)

pause
