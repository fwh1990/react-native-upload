#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

source $libs/export-method.sh "$@"

echo -e "\n\033[32mBuilding ios app...\033[0m\n"

sh $libs/archive.sh
sh $libs/export-ipa.sh $export_method

echo -e "\nView ipa file at: \033[32m./ios/build/ipa-$export_method\033[0m\n"
