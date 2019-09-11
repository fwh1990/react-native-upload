#!/usr/bin/env bash

set -e

# Variable export_method can be one of [app-store, ad-hoc]
plist_file=$1
export_dir=$2

rm -rf $export_dir

# Export
# The same as Xcode -> Window -> Organizer -> Export
xcodebuild -exportArchive \
  -archivePath ./ios/build/archive.xcarchive \
  -exportPath $export_dir \
  -exportOptionsPlist $plist_file \
  -allowProvisioningUpdates
