#!/usr/bin/env bash

# Build for android
# The apk file will be at
# android/app/build/outputs/apk/app-release.apk
cd android
rm -rf build/ app/build/
./gradlew assembleRelease
cd -
