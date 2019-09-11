#!/usr/bin/env bash


ios_export_plist=$(node $libs/get-config.js $1)

if [ ! -f $ios_export_plist ]
then
  echo -e "\n\033[031mFile $ios_export_plist is not found\033[0m\n"
  exit 1
fi
