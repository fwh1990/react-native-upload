#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

pgy_host=https://www.pgyer.com/apiv2/app/upload
api_key=$(node $libs/get-config.js pgy.pgy_api_key)
ios_export_method=$(node $libs/get-config.js pgy.ios_export_method)

sh $libs/build-android.sh
sh $libs/archive.sh
sh $libs/export-ipa.sh $ios_export_method

android_app=$(ls -l ./android/app/build/outputs/apk/release/*.apk | tail -n 1 | awk '{print $NF}')
ios_app=$(ls ./ios/build/ipa-${ios_export_method}/*.ipa)

# Android
if [ -n "$android_app" ]
then
  echo -e "\033[32mUploading android to pgyer...\033[0m"
  result=$(
    curl \
      --form "file=@$android_app" \
      --form "_api_key=$api_key" \
      ${pgy_host}
  )
  node $libs/validate-pgy.js "$result"
else
  echo -e "\033[31mAndroid file is missing.\033[0m"
fi

# Ios
if [ -n "$ios_app" ]
then
  echo -e "\033[32mUploading ios to pgyer...\033[0m"
  result=$(
    curl \
      --form "file=@$ios_app" \
      --form "_api_key=$api_key" \
      ${pgy_host}
  )
  node $libs/validate-pgy.js "$result"
else
  echo -e "\033[31mIos file is missing.\033[0m"
fi
