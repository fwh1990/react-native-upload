#!/usr/bin/env bash

mkdir -p ios/build

rm -rf ios/build/archive.xcarchive

project_name=$(ls ios | grep '.xcodeproj' | cut -d. -f1)

# Archive
# The same as Xcode -> Product -> Archive
xcodebuild clean \
  -project ./ios/${project_name}.xcodeproj \
  -scheme ${project_name}

xcodebuild archive \
  -project ./ios/${project_name}.xcodeproj \
  -scheme ${project_name} \
  -configuration Release \
  -archivePath ./ios/build/archive.xcarchive
