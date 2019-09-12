#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

ios_export_plist=$(node $libs/get-config.js ios-export-plist# "$@")

if [ -z "$ios_export_plist" ]
then
  echo -e "\n\033[31mError: The parameter \"ios-export-plist\" is required.\033[0m\n" 1>&2
  echo -e "\033[33mnpx upload-build-ios --ios-export-plist=path/to/xxx.plist\033[0m\n" 1>&2
  exit 1
fi

ios_app_save_dir=./ios/build/app-$(date +%Y-%m-%d-%H-%M-%S)

echo -e "\n\033[32mBuilding ios app...\033[0m\n"

bash $libs/archive.sh
bash $libs/export-ipa.sh $ios_export_plist $ios_app_save_dir

echo -e "\nView ipa file at: \033[32m$ios_app_save_dir\033[0m\n"
