#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

ios_export_method=$(node $libs/get-config.js test_flight.ios_export_method)

sh $libs/appstore.sh $ios_export_method

echo -e "\033[32m[test-flight] Done!\033[0m"
