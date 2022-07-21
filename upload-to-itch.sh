#!/bin/bash
CURRENT_DIR=$(dirname "$(readlink -f "$0")")
APK="$CURRENT_DIR/build/AliceMaze.apk"
WINDOWS="$CURRENT_DIR/build/windows/"

echo Uploading to Itch...
butler -v push "$APK" "malcolmnixon/alice-maze:android"
butler -v push "$WINDOWS" "malcolmnixon/alice-maze:windows"

echo Done.
