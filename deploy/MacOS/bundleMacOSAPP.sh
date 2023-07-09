#!/bin/bash
cd "$(dirname "$0")/../.."

echo "Building ui ..."
cd qt5-ui/
mkdir -p build/
cd build
cmake ..
make
cd ../..

echo "Building binary ..."
stack build

echo 'Building bundle ...'
rm -rf XPlayer.app
mkdir -p XPlayer.app/Contents/{MacOS,Resources}
cp qt5-ui/resources/XPlayer.icns XPlayer.app/Contents/Resources
cp deploy/MacOS/Info.plist XPlayer.app/Contents/
cp "$(stack path --local-install-root)/bin/XPlayer" XPlayer.app/Contents/MacOS/XPlayer

echo 'Packaging Qt Frameworks ...'
macdeployqt XPlayer.app

echo 'Pruning Frameworks ...'
rm -rf XPlayer.app/Contents/Frameworks/QtPdf.framework
rm -rf XPlayer.app/Contents/Frameworks/QtQml.framework
rm -rf XPlayer.app/Contents/Frameworks/QtQmlModels.framework
rm -rf XPlayer.app/Contents/Frameworks/QtQuick.framework
rm -rf XPlayer.app/Contents/Frameworks/QtPdf.framework

echo "App is available at $(pwd)/XPlayer.app"
