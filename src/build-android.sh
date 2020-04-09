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

eval $(node $libs/pack-type.js "$@")
# pack_variant=
# pack_output_path=

bash $libs/build-android.sh $pack_variant

echo -e "\nView apk file at: \033[32m./android/app/build/outputs/apk/$pack_output_path\033[0m\n"
