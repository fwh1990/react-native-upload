#!/usr/bin/env bash

set -e

pack_type=$1

# Build for android
# The apk file will be at
# android/app/build/outputs/apk/app-release.apk
cd android
rm -rf build/ app/build/

if [ $pack_type = "debug" ]
then
    ./gradlew assembleDebug
else
    ./gradlew assembleRelease
fi

cd -
