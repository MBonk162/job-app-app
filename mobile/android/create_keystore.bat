@echo off
REM Script to create Android signing keystore

echo Creating Android signing keystore...
echo.
echo You'll be asked for:
echo   - Keystore password (remember this!)
echo   - Key alias password (can be same as keystore password)
echo   - Your name, organization, etc.
echo.

REM Create keystore in android/app directory
keytool -genkey -v -keystore app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

echo.
echo Keystore created at: android/app/upload-keystore.jks
echo.
echo IMPORTANT: Keep this file and passwords safe!
echo You'll need them for all future app updates.
pause
