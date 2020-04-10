#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

log_prefix="Builder"
android=$(node $libs/get-config.js android#1 "$@")
ios=$(node $libs/get-config.js ios#1 "$@")

eval $(node $libs/pack-type.js "$@")
# pack_variant=
# pack_output_path=

if [ $android -eq 0 ]
then
  echo -e "\n\033[33m[$log_prefix] Android is skipped.\033[0m\n"
  sleep 1
else 
  echo -e "\n\033[32m[$log_prefix] Building android app...\033[0m\n"
  bash $libs/build-android.sh $pack_variant
fi

if [ $ios -eq 0 ]
then
  echo -e "\n\033[33m[$log_prefix] Ios is skipped.\033[0m\n"
  sleep 1
else
  ios_export_plist=$(node $libs/get-config.js ios-export-plist# "$@")

  if [ -z "$ios_export_plist" ]
  then
    echo -e "\n\033[31m[$log_prefix] Error: The parameter \"ios-export-plist\" is required.\033[0m\n" 1>&2
    echo -e "\033[33m[$log_prefix] npx upload-build --ios-export-plist=path/to/xxx.plist\033[0m\n" 1>&2
    exit 1
  fi

  ios_app_save_dir=./ios/build/app-$(date +%Y-%m-%d-%H-%M-%S)

  echo -e "\n\033[32m[$log_prefix] Building ios app...\033[0m\n"

  bash $libs/archive.sh
  bash $libs/export-ipa.sh $ios_export_plist  $ios_app_save_dir
fi

if [ $android -eq 1 ]
then
  echo -e "\n[$log_prefix] View apk file at: \033[32m./android/app/build/outputs/apk/$pack_output_path\033[0m"
fi

if [ $ios -eq 1 ]
then
  echo -e "\n[$log_prefix] View ipa file at: \033[32m$ios_app_save_dir\033[0m\n"
fi
