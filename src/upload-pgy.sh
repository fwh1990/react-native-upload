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

android=$(node $libs/get-config.js android#1 "$@")
ios=$(node $libs/get-config.js ios#1 "$@")

if [ $android -eq 0 ]
then
  echo -e "\n\033[33m[pgyer] Android is skipped.\033[0m\n"
  sleep 1
else
  sh $libs/build-android.sh
  android_app=$(ls -l ./android/app/build/outputs/apk/release/*.apk | tail -n 1 | awk '{print $NF}')
fi

if [ $ios -eq 0 ]
then
  echo -e "\n\033[33m[pgyer] Ios is skipped.\033[0m\n"
  sleep 1
else
  source $libs/ipa-export-plist.sh pgy.ios_export_plist
  ios_app_save_dir=./ios/build/rn-upload-app-temp

  sh $libs/archive.sh
  sh $libs/export-ipa.sh $ios_export_plist $ios_app_save_dir

  ios_app=$(ls $ios_app_save_dir/*.ipa)
fi

# Android
[ \( $android -ne 0 \) -a \( -z "$android_app" \) ] && echo -e "\033[31m[pgyer] Android file is missing.\033[0m"

if [ \( $android -ne 0 \) -a \( -n "$android_app" \) ]
then
  echo -e "\033[32m[pgyer] Uploading android...\033[0m"
  result=$(
    curl \
      --form "file=@$android_app" \
      --form "_api_key=$api_key" \
      --form "buildUpdateDescription=$(node $libs/get-config.js log# "$@")" \
      ${pgy_host}
  )
  node $libs/validate-pgy.js "$result"
fi

# Ios
[ \( $ios -ne 0 \) -a \( -z "$ios_app" \) ] && echo -e "\033[31m[pgyer] Ios file is missing.\033[0m"

if [ \( $ios -ne 0 \) -a \( -n "$ios_app" \) ]
then
  echo -e "\033[32m[pgyer] Uploading ios...\033[0m"
  result=$(
    curl \
      --form "file=@$ios_app" \
      --form "_api_key=$api_key" \
      --form "buildUpdateDescription=$(node $libs/get-config.js log# "$@")" \
      ${pgy_host}
  )
  node $libs/validate-pgy.js "$result"
fi

echo -e "\033[32m[pgyer] Done!\033[0m"
