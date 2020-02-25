#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

log_prefix="App Store"
ios_export_plist=$(bash $libs/ipa-export-plist.sh app_store.ios_export_plist)
username=$(node $libs/get-config.js app_store.user_name#)
api_key=$(node $libs/get-config.js app_store.api_key#)

if [ -n "$username" ]
then
  password=$(node $libs/get-config.js app_store.user_password)
elif [ -n "$api_key" ]
then
  api_issuer=$(node $libs/get-config.js app_store.api_issuer)
else
  echo -e "\033[031m[$log_prefix] You are required to provide either app_store.user_* or app_store.api_*\033[0m"
  exit 1
fi

source $libs/appstore.sh
