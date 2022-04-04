#!/usr/bin/env bash
# Run from root of project
# https://love2d.org/wiki/Game_Distribution
# TODO Don't forget to download the distro folders for win32,64 and mac and unzip in the build folders

GAME_NAME=vesuvius
LOVE_V=11.4
COMPANY_NAME=MountainLabGames
ROOT_DIR=$(pwd)

# Build the game for the love2d engine
zip -9 -r build/${GAME_NAME}.love . -x "build/*" -x "output/*" -x ".*" -FSr

if [[ ! -d "output" ]]; then
    mkdir output
fi

# Compile for different platforms w/ source (love2d)

# TODO allow each build type to be toggleable
cd build
if  [[ ! -d "love.app" ]]; then
    curl -L -o ./love-${LOVE_V}-macos.zip https://github.com/love2d/love/releases/download/$LOVE_V/love-$LOVE_V-macos.zip
    unzip love-${LOVE_V}-macos.zip
fi

if [[ ! -d "love-${LOVE_V}-ios-source" ]]; then
    curl -L -o ./love-${LOVE_V}-ios-source.zip https://github.com/love2d/love/releases/download/$LOVE_V/love-$LOVE_V-ios-source.zip
    unzip love-${LOVE_V}-ios-source.zip
fi

if [[ ! -d "love-${LOVE_V}-win32" ]]; then
    curl -L -o ./love-${LOVE_V}-win32.zip https://github.com/love2d/love/releases/download/${LOVE_V}/love-${LOVE_V}-win32.zip
    unzip love-${LOVE_V}-win32.zip
fi

if [[ ! -d "love-${LOVE_V}-win64" ]]; then
    curl -L -o ./love-${LOVE_V}-win64.zip https://github.com/love2d/love/releases/download/${LOVE_V}/love-${LOVE_V}-win64.zip
    unzip love-${LOVE_V}-win64.zip
fi
cd ..

# TODO download Android or others

## Windows
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


# Mac TODO figure out why game.app isn't working
mkdir build/${GAME_NAME}.app/
cp -r build/love.app/ build/${GAME_NAME}.app
cp -r build/__MACOSX/ build/${GAME_NAME}.app/
cp build/${GAME_NAME}.love build/${GAME_NAME}.app/Contents/Resources/${GAME_NAME}.love
## modify plist
###    <key>CFBundleIdentifier</key>
sed -i '' 's@<string>org.love2d.love</string>@<string>com.'"${COMPANY_NAME}"'.'"${GAME_NAME}"'</string>@g' build/${GAME_NAME}.app/Contents/Info.plist
###    <key>CFBundleName</key>
sed -i '' 's@<string>LÖVE</string>@<string>'"${GAME_NAME}"'</string>@g' build/${GAME_NAME}.app/Contents/Info.plist
###    <key>UTExportedTypeDeclarations</key>
sed -i '' 's@<key>UTExportedTypeDeclarations</key>@@g' build/${GAME_NAME}.app/Contents/Info.plist

# TODO delete
# <key>UTExportedTypeDeclarations</key>
#	<array>
#		<dict>
#			<key>UTTypeConformsTo</key>
#			  ...
#   </array>
#cd build/
#ls
#zip -9 -r ../output/${GAME_NAME}-osx.zip ${GAME_NAME}.app -FSr
#cd ..


## Iphone
# https://github.com/love2d/love/releases/download/11.3/love-11.3-ios-source.zip
# use mac dep
# unzip
# Open platform/xcode/love.xcodeproj with Xcode.
#Select love-ios target (not love-macosx)
# in "Signing and Capabilities" tab of love-ios target, set "Team" to your team (you can make a personal one in preferences)
#Select Build Phases of the 'love-ios' target and add your 'game.love' file into Copy Bundle Resources.
# connect a device
# build

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

# Run with command `love`
# Add to zsh
# nano .zshrc
# alias love="/Applications/love.app/Contents/macOS/love"
