#!/usr/bin/env sh
# Starts the GymOS backend (API :8080, web app :8082) for the web app and the
# Android app. Phones must be on the same Wi-Fi as this computer.
cd "$(dirname "$0")/gymos2/gymos2_server" || exit 1
echo "Starting GymOS server... keep this window open while using the app."
exec dart run bin/main.dart --apply-migrations
