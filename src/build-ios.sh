#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

ios_export_plist=$(bash $libs/ipa-export-plist.sh ios-export-plist)
ios_app_save_dir=./ios/build/rn-upload-app-build-only

echo -e "\n\033[32mBuilding ios app...\033[0m\n"

bash $libs/archive.sh
bash $libs/export-ipa.sh $ios_export_plist $ios_app_save_dir

echo -e "\nView ipa file at: \033[32m$ios_app_save_dir\033[0m\n"
