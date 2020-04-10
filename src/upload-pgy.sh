#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

log_prefix="Pgyer"
pgy_host=https://www.pgyer.com/apiv2/app/upload
api_key=$(node $libs/get-config.js pgy.pgy_api_key)
install_type=$(node $libs/get-config.js pgy.pgy_install_type)

if [ $install_type -eq 2 ]
then
  install_password=$(node $libs/get-config.js pgy.pgy_install_password)
else
  install_password=$(node $libs/get-config.js pgy.pgy_install_password#)
fi

android=$(node $libs/get-config.js android#1 "$@")
ios=$(node $libs/get-config.js ios#1 "$@")

if [ $android -eq 0 ]
then
  echo -e "\n\033[33m[$log_prefix] Android is skipped.\033[0m\n"
  sleep 1
else
  echo -e "\033[32m[$log_prefix] Building android app...\033[0m"
  sleep 1

  pack_variant=$(node $libs/pack-type.js "$@")

  sh $libs/build-android.sh $pack_variant
  android_apps=$(find ./android/app/build/outputs/apk -type f -name *.apk)
fi

if [ $ios -eq 0 ]
then
  echo -e "\n\033[33m[$log_prefix] Ios is skipped.\033[0m\n"
  sleep 1
else
  echo -e "\033[32m[$log_prefix] Building ios app...\033[0m"
  sleep 1

  ios_export_plist=$(bash $libs/ipa-export-plist.sh pgy.ios_export_plist)
  ios_app_save_dir=./ios/build/rn-upload-app-temp

  sh $libs/archive.sh
  sh $libs/export-ipa.sh $ios_export_plist $ios_app_save_dir

  ios_app=$(ls $ios_app_save_dir/*.ipa)
fi

if [ $android -ne 0 ]
then

  for android_app in $android_apps
  do
    echo -e "\033[32m[$log_prefix] Uploading android from $android_app ...\033[0m"
    result=$(
      curl \
        --form "file=@$android_app" \
        --form "_api_key=$api_key" \
        --form "buildInstallType=$install_type" \
        --form "buildPassword=$install_password" \
        --form "buildUpdateDescription=$(node $libs/get-config.js log# "$@")" \
        ${pgy_host}
    )
    node $libs/validate-pgy.js "$result"
  done
fi

# Ios
[ \( $ios -ne 0 \) -a \( -z "$ios_app" \) ] && echo -e "\033[31m[$log_prefix] Ios file is missing.\033[0m"

if [ \( $ios -ne 0 \) -a \( -n "$ios_app" \) ]
then
  echo -e "\033[32m[$log_prefix] Uploading ios...\033[0m"
  result=$(
    curl \
      --form "file=@$ios_app" \
      --form "_api_key=$api_key" \
      --form "buildInstallType=$install_type" \
      --form "buildPassword=$install_password" \
      --form "buildUpdateDescription=$(node $libs/get-config.js log# "$@")" \
      ${pgy_host}
  )
  node $libs/validate-pgy.js "$result"
fi

echo -e "\033[32m[$log_prefix] Done!\033[0m"
