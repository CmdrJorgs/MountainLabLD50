#!/usr/bin/env bash
# Run from root of project
# https://love2d.org/wiki/Game_Distribution
# TODO Don't forget to download the distro folders for win32,64 and mac and unzip in the build folders

GAME_NAME=vesuvius
LOVE_V=11.3
COMPANY_NAME=MountainLabGames
ROOT_DIR=$(pwd)

# Build
zip -9 -r build/${GAME_NAME}.love . -x "build/*" -x "output/*" -x ".*" -x "_lesson/*" -FSr
if [[ ! -d "output" ]]; then
    mkdir output
fi
# Compile for different platforms

# ========================= Windows ====================================
### Build
rm build/love-${LOVE_V}-win32/${GAME_NAME}.exe
cat build/love-${LOVE_V}-win32/lovec.exe build/${GAME_NAME}.love > build/love-${LOVE_V}-win32/${GAME_NAME}.exe
rm build/love-${LOVE_V}-win64/${GAME_NAME}.exe
cat build/love-${LOVE_V}-win64/lovec.exe build/${GAME_NAME}.love > build/love-${LOVE_V}-win64/${GAME_NAME}.exe
### Zip
cd build/love-${LOVE_V}-win32/
zip -9 -r ../../output/${GAME_NAME}-win32.zip . -x "*.DS_Store" -FSr
cd ../love-${LOVE_V}-win64/
zip -9 -r ../../output/${GAME_NAME}-win64.zip . -x "*.DS_Store" -FSr
cd "$ROOT_DIR"

# ========================= Mac ========================================
## https://github.com/love2d/love/releases/download/11.3/love-11.3-macos.zip

# TODO: Download the LOVE2D Mac app. Ensure that there isn't any weird Apple-only software needed to do this

#mkdir build/${GAME_NAME}.app/
#cp -r build/love.app/ build/${GAME_NAME}.app
#cp build/${GAME_NAME}.love build/${GAME_NAME}.app/Contents/Resources/${GAME_NAME}.love
### modify plist
####    <key>CFBundleIdentifier</key>
#sed -i '' 's@<string>org.love2d.love</string>@<string>com.'"${COMPANY_NAME}"'.'"${GAME_NAME}"'</string>@g' build/${GAME_NAME}.app/Contents/Info.plist
####    <key>CFBundleName</key>
#sed -i '' 's@<string>LÖVE</string>@<string>'"${GAME_NAME}"'</string>@g' build/${GAME_NAME}.app/Contents/Info.plist
####    <key>UTExportedTypeDeclarations</key>
#sed -i '' 's@<key>UTExportedTypeDeclarations</key>@@g' build/${GAME_NAME}.app/Contents/Info.plist

# ==================== Linux (AppImage) ==================================

# TODO:
# 1. Download the AppImage for LOVE from https://github.com/love2d/love/releases/download/11.4/love-11.4-x86_64.AppImage
# 2. Execute it (setting permissions first) with --appimage-extract, which creates a squashfs-root
# 3. $ cat squashfs-root/bin/love ${GAME_NAME}.love > squashfs-root/bin/${GAME_NAME}
# 4. $ chmod +x squashfs-root/bin/${GAME_NAME}
# 5. Download the AppImageTool:
#    $ wget "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
#    $ chmod a+x appimagetool-x86_64.AppImage
# 6. Modify love.desktop to match my game description, including changing `Exec=love %f` to `Exec=${GAME_NAME} %f`
#    (You may just want to have the new love.desktop resource file lying around, so go ahead and do all these steps manually first)
# 7. Change the PNG or SVG icon (put it beside the love.desktop and modify `Icon=love` to `Icon=${GAME_NAME}`)
# 8. Repackage to AppImage by using:
#    $ appimagetool squashfs-root ${GAME_NAME}.AppImage


## Android - Broken
#cd build/
#if [ ! -d "love-android" ]; then
#    git clone --recurse-submodules https://github.com/love2d/love-android
#fi
#mkdir love-android/app/src/main/assets
#cp ${GAME_NAME}.love love-android/app/src/main/assets/${GAME_NAME}.love
#export ANDROID_NDK=$HOME/Library/Android/sdk/ndk/21.3.6528147
#cd love-android
#chmod +x gradlew
## IF NDK fails, go to android project in android studio > Project Structure > SDK location and set above env var
## ndk can be set with local.properties file in project too ndk.dir=$HOME/Library/Android/sdk/ndk/21.3.6528147
#./gradlew assemble
#cd ..
