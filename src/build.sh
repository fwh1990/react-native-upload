#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

echo -e "\n\033[32mBuilding android app...\033[0m\n"

sh $libs/build-android.sh


source $libs/export-method.sh "$@"

echo -e "\n\033[32mBuilding ios app...\033[0m\n"

sh $libs/archive.sh
sh $libs/export-ipa.sh $export_method

echo -e "\nView apk file at: \033[32m./android/app/build/outputs/apk/release\033[0m\n"
echo -e "\nView ipa file at: \033[32m./ios/ipa-$export_method\033[0m\n"
