#!/usr/bin/env bash

set -e

export_method=$(node $libs/get-config.js ios-export-method# "$@")
methods=$(echo -e "appstore\nad-hoc\nenterprise\ndevelopment\n$export_method")

if [ \( -z "$export_method" \) -o \( $(echo "$methods" | sort -u | wc -l) -ne 4 \) ]
then
  echo -e "\n\033[31mExport Method should be one of 'appstore, ad-hoc, enterprise, development'\033[0m\n"
  echo -e "\033[33m\nnpx build-ios --ios-export-method xxx\n\033[0m"
  exit 1
fi
