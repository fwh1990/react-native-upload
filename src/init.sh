#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

if [ -e "./upload.json" ]
then
  echo -e '\n\033[31mThe config file "upload.json" had been created already, delete before you can regenerate it.\033[0m\n'
  exit 1
fi

cp $libs/upload.json ./

echo -e '\n\033[32mThe config file "upload.json" has been created.\033[0m\n'
