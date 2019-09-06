#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

sh $libs/appstore.sh app-store

echo -e "\033[32m[appstore] Done!\033[0m"
