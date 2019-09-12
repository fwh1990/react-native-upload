#!/usr/bin/env bash

set -e

libs=$(dirname $0)

ios_export_plist=$(node $libs/get-config.js "$@")

if [ ! -f $ios_export_plist ]
then
  echo -e "\n\033[031mFile $ios_export_plist is not found\033[0m\n" 1>&2
  exit 1
fi

echo $ios_export_plist
