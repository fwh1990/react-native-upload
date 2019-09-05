#!/usr/bin/env bash

set -e

libs=$(dirname $0)

USERNAME=$(node $libs/get-config.js app_store.username)
PASSWORD=$(node $libs/get-config.js app_store.random_password)
export_method=$1

sh $libs/archive.sh
sh $libs/export-ipa.sh $export_method
ios_app=$(ls ./ios/build/ipa-$export_method/*.ipa)

# FIXME: I get the error "altool: command not found" when using alias
#alias altool="/Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"

echo -e "\033[032mValidating ios app...\033[0m"
/Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool \
  --validate-app \
  --file "$ios_app" \
  --type "ios" \
  --username "$USERNAME" \
  --password "$PASSWORD"

# Upload to https://appstoreconnect.apple.com/
echo -e "\033[032mUploading ios app to appstore...\033[0m"
/Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool \
  --upload-app \
  --file "$ios_app" \
  --type "ios" \
  --username "$USERNAME" \
  --password "$PASSWORD"
