#!/usr/bin/env bash

function getPlist() {
  IOS_PROJECT_NAME=$(ls ./ios | grep .xcodeproj | head -n 1 | cut -d. -f1)
  IOS_PLIST_PATH=./ios/$IOS_PROJECT_NAME/Info.plist

  if [ ! -f $IOS_PLIST_PATH ]
  then
    echo -e "\n\033[31mFile \"$IOS_PLIST_PATH\" is not found.\033[0m\n"
    return 1
  fi

  KEY_LINE=$(cat $IOS_PLIST_PATH | grep  -n "$1" | cut -d: -f1)

  if [ -z "$KEY_LINE" ]
  then
    echo -e "\n\033[31mProperty \"$1\" is not found in file Info.plist\033[0m\n"
    return 1
  fi

  echo $(sed -n "$((KEY_LINE + 1))p" "$IOS_PLIST_PATH" | cut -d'>' -f2 | cut -d'<' -f1)
  return 0
}
