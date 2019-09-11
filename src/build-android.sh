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

bash $libs/build-android.sh

echo -e "\nView apk file at: \033[32m./android/app/build/outputs/apk/release\033[0m\n"
