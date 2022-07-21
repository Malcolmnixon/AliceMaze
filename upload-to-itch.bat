SET CURRENT_DIR=%~dp0
SET APK=%CURRENT_DIR%/build/AliceMaze.apk
SET WINDOWS=%CURRENT_DIR%/build/windows/

echo Uploading to Itch...
butler -v push "%APK%" "malcolmnixon/alice-maze:android"
butler -v push "%WINDOWS%" "malcolmnixon/alice-maze:windows"

echo Done.
