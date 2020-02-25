#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

log_prefix="Test Flight"
ios_export_plist=$(bash $libs/ipa-export-plist.sh test_flight.ios_export_plist)
username=$(node $libs/get-config.js test_flight.user_name,app_store.user_name#)
api_key=$(node $libs/get-config.js test_flight.api_key,app_store.api_key#)

if [ -n "$username" ]
then
  password=$(node $libs/get-config.js test_flight.user_password,app_store.user_password)
elif [ -n "$api_key" ]
then
  api_issuer=$(node $libs/get-config.js test_flight.api_issuer,app_store.api_issuer)
else
  echo -e "\033[031m[$log_prefix] You are required to provide either {test_flight|app_store}.user_* or {test_flight|app_store}.api_*\033[0m"
  exit 1
fi

source $libs/appstore.sh
