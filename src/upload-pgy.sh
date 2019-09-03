#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

PGY_HOST=https://www.pgyer.com/apiv2/app/upload
API_KEY=$(node $libs/get-config.js pgy.pgy_api_key)
EXPORT_METHOD=$(node $libs/get-config.js pgy.ios_export_method)

sh $libs/build-android.sh
sh $libs/archive.sh
sh $libs/export-ipa.sh $EXPORT_METHOD

APK_PATH=$(ls ./android/app/build/outputs/apk/release/*.apk)
IPA_PATH=$(ls ./ios/build/ipa-${EXPORT_METHOD}/*.ipa)

# Android
if [ -n "$APK_PATH" ]
then
  echo -e "\033[32mUploading android to pgyer...\033[0m"
  result=$(
    curl \
      --form "file=@$APK_PATH" \
      --form "_api_key=$API_KEY" \
      ${PGY_HOST}
  )
  node $libs/validate-pgy.js "$result"
else
  echo -e "\033[31mAndroid file is missing.\033[0m"
fi

# Ios
if [ -n "$IPA_PATH" ]
then
  echo -e "\033[32mUploading ios to pgyer...\033[0m"
  result=$(
    curl \
      --form "file=@$IPA_PATH" \
      --form "_api_key=$API_KEY" \
      ${PGY_HOST}
  )
  node $libs/validate-pgy.js "$result"
else
  echo -e "\033[31mIos file is missing.\033[0m"
fi
