#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

FIR_HOST=http://api.fir.im/apps
API_TOKEN=$(node $libs/get-config.js fir.fir_api_token)
EXPORT_METHOD=$(node $libs/get-config.js fir.ios_export_method)

source $libs/get-android-gradle.sh
ANDROID_BUNDLE_ID=$(getAndroidGradle applicationId)
ANDROID_BUILD_CODE=$(getAndroidGradle versionCode)
ANDROID_BUILD_VERSION=$(getAndroidGradle versionName)
ANDROID_APP_NAME=$(cat ./android/app/src/main/res/values/strings.xml | grep 'name="app_name"' | cut -d'>' -f2 | cut -d'<' -f1)

source $libs/get-plist.sh
IOS_APP_NAME=$(getPlist CFBundleDisplayName)
IOS_BUNDLE_ID=$(getPlist CFBundleIdentifier)
IOS_BUILD_CODE=$(getPlist CFBundleVersion)
IOS_BUILD_VERSION=$(getPlist CFBundleShortVersionString)

sh $libs/build-android.sh

# Get data after release.
# ANDROID_OUTPUT_PATH=./android/app/build/outputs/apk/release/output.json
# ANDROID_BUILD_CODE=$(echo "$(node $libs/format-json.js $(cat $ANDROID_OUTPUT_PATH))" | grep versionCode | cut -d: -f2 | tr -d ', ')
# ANDROID_BUILD_VERSION=$(echo "$(node $libs/format-json.js $(cat $ANDROID_OUTPUT_PATH))" | grep versionName | cut -d: -f2 | tr -d '," ')

sh $libs/archive.sh
sh $libs/export-ipa.sh $EXPORT_METHOD

APK_PATH=$(ls ./android/app/build/outputs/apk/release/*.apk)
IOS_PATH=$(ls ./ios/build/ipa-${EXPORT_METHOD}/*.ipa)

# Android
if [ -n "$APK_PATH" ]
then
  echo -e "\033[32mGetting android token from fir.im...\033[0m"
  token_result=$(
    curl \
      --request "POST" \
      --header "Content-Type: application/json" \
      --data "{\"type\":\"android\", \"bundle_id\":\"$ANDROID_BUNDLE_ID\", \"api_token\":\"$API_TOKEN\"}" \
      ${FIR_HOST}
  )
  token_log=$(node $libs/validate-fir-token.js "$token_result")
  eval "$token_log"

  echo -e "\033[32mUploading android binary to fir.im...\033[0m"
  result=$(
    curl \
      --form "file=@${APK_PATH}" \
      --form "key=${BINARY_KEY}" \
      --form "token=${BINARY_TOKEN}" \
      --form "x:name=${ANDROID_APP_NAME}" \
      --form "x:version=${ANDROID_BUILD_VERSION}" \
      --form "x:build=${ANDROID_BUILD_CODE}" \
      ${BINARY_UPLOAD_URL}
  )
  node $libs/validate-fir.js "$result"
  echo -e "\nVisit link: \033[32mhttps://fir.im/${SHORT_URL}\033[0m\n"
else
  echo -e "\033[31mAndroid file is missing.\033[0m"
fi

# Ios
if [ -n "$IOS_PATH" ]
then
  echo -e "\033[32mGetting ios token from fir.im...\033[0m"
  token_result=$(
    curl \
      --request "POST" \
      --header "Content-Type: application/json" \
      --data "{\"type\":\"ios\", \"bundle_id\":\"$ANDROID_BUNDLE_ID\", \"api_token\":\"$API_TOKEN\"}" \
      ${FIR_HOST}
  )
  token_log=$(node $libs/validate-fir-token.js "$token_result")
  eval "$token_log"

  echo -e "\033[32mUploading ios binary to fir.im...\033[0m"
  result=$(
    curl \
      --form "file=@${IOS_PATH}" \
      --form "key=${BINARY_KEY}" \
      --form "token=${BINARY_TOKEN}" \
      --form "x:name=${IOS_APP_NAME}" \
      --form "x:version=${IOS_BUILD_VERSION}" \
      --form "x:build=${IOS_BUILD_CODE}" \
      ${BINARY_UPLOAD_URL}
  )
  node $libs/validate-fir.js "$result"
  echo -e "\nVisit link: \033[32mhttps://fir.im/${SHORT_URL}\033[0m\n"
else
  echo -e "\033[31mIos file is missing.\033[0m"
fi
