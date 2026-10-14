@echo off
rem Starts the GymOS backend (API :8080, web app :8082) for the web app and
rem the Android app. Phones must be on the same Wi-Fi as this computer.
cd /d "%~dp0gymos2\gymos2_server"
echo Starting GymOS server... keep this window open while using the app.
dart run bin/main.dart --apply-migrations
pause
