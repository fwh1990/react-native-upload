#!/usr/bin/env bash

set -e

# @see src/upload-appstore.sh
# @see src/upload-testflight.sh

ios_app_save_dir=./ios/build/rn-upload-app-temp
bash $libs/archive.sh
bash $libs/export-ipa.sh $ios_export_plist $ios_app_save_dir
ios_app=$(ls $ios_app_save_dir/*.ipa)
type="ios"

# In some case, it will fail when uploading, we'd better remove these folders.
rm -rf ~/.itmstransporter/ ~/.old_itmstransporter/

echo -e "\033[032m[$log_prefix] Validating ios app...\033[0m"

if [ -n "$username" ]
then
  xcrun altool \
    --validate-app \
    --file "$ios_app" \
    --type "$type" \
    --username "$username" \
    --password "$password"
else
  xcrun altool \
    --validate-app \
    --file "$ios_app" \
    --type "$type" \
    --apiIssuer "$api_issuer" \
    --apiKey "$api_key"
fi

# Upload to https://appstoreconnect.apple.com/
echo -e "\033[032m[$log_prefix] Uploading ios app...\033[0m"

if [ -n "$username" ]
then
  xcrun altool \
    --upload-app \
    --file "$ios_app" \
    --type "$type" \
    --username "$username" \
    --password "$password"
else
  xcrun altool \
    --upload-app \
    --file "$ios_app" \
    --type "$type" \
    --apiIssuer "$api_issuer" \
    --apiKey "$api_key"
fi

echo -e "\033[32m[$log_prefix] Done!\033[0m"
