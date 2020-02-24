#!/usr/bin/env bash

set -e

libs=$(dirname $0)

username=$(node $libs/get-config.js app_store.username)
password=$(node $libs/get-config.js app_store.random_password)
ios_export_plist=$1
ios_app_save_dir=./ios/build/rn-upload-app-temp

bash $libs/archive.sh
bash $libs/export-ipa.sh $ios_export_plist $ios_app_save_dir
ios_app=$(ls $ios_app_save_dir/*.ipa)

echo -e "\033[032mValidating ios app...\033[0m"
xcrun altool \
  --validate-app \
  --file "$ios_app" \
  --type "ios" \
  --username "$username" \
  --password "$password"

# In some case, it will fail when uploading, we'd better remove these folders.
rm -rf ~/.itmstransporter/ ~/.old_itmstransporter/

# Upload to https://appstoreconnect.apple.com/
echo -e "\033[032mUploading ios app to appstore...\033[0m"
xcrun altool \
  --upload-app \
  --file "$ios_app" \
  --type "ios" \
  --username "$username" \
  --password "$password"
