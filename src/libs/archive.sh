#!/usr/bin/env bash

set -e

# Archive
# The same as Xcode -> Product -> Archive

mkdir -p ios/build
rm -rf ios/build/archive.xcarchive

# Since RN-0.60，Pods is required and we can only use workspace to archive app
# Rememver: .xcodeproj dirtory is useless once .xcworkspace dirtory exists
workspace=$(ls ios | grep '.xcworkspace')
archive_path=./ios/build/archive.xcarchive

if [ -n "$workspace" ]
then
  project_name=$(echo $workspace | cut -d. -f1)

  xcodebuild clean \
    -workspace "./ios/$workspace" \
    -scheme "$project_name"

  xcodebuild archive \
    -workspace "./ios/$workspace" \
    -scheme "$project_name" \
    -configuration "Release" \
    -archivePath "$archive_path" \
    -allowProvisioningUpdates \
    -showBuildTimingSummary
else
  project=$(ls ios | grep '.xcodeproj')
  project_name=$(echo $project | cut -d. -f1)

  xcodebuild clean \
    -project "./ios/$project" \
    -scheme ${project_name}

  xcodebuild archive \
    -project "./ios/$project" \
    -scheme "$project_name" \
    -configuration "Release" \
    -archivePath "$archive_path" \
    -allowProvisioningUpdates \
    -showBuildTimingSummary
fi
