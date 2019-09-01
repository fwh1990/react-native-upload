#!/usr/bin/env bash

set -e

dir=$(dirname $0)/$(dirname $(readlink $0))
libs=$dir/libs

sh $libs/build-android.sh

echo -e "\nView apk file at: \033[32m./android/app/build/outputs/apk/release\033[0m\n"
