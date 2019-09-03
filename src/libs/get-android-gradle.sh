#!/usr/bin/env bash

function getAndroidGradle() {
  # Trim whitespace by using: echo $LINE_DATA
  LINE_DATA=$(cat ./android/app/build.gradle | grep "$1")

  if [ -z "$LINE_DATA" ]
  then
    echo -e "\n\033[31mProperty \"$1\" is not found in file android/app/build.gradle\033[0m\n"
    return 1
  fi

  echo $(echo $LINE_DATA | cut -d' ' -f2 | tr -d '"')

  return 0
}
