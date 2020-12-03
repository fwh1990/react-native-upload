#!/usr/bin/env bash

set -e

pack_variant=$1

# Build for android
# The apk file will be at
# android/app/build/outputs/apk/app-release.apk
cd android
rm -rf build/ app/build/

./gradlew assemble$pack_variant

cd -
