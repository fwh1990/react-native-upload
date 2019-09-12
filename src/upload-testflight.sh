#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

ios_export_plist=$(bash $libs/ipa-export-plist.sh test_flight.ios_export_plist)

bash $libs/appstore.sh $ios_export_plist

echo -e "\033[32m[test-flight] Done!\033[0m"
