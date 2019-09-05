#!/usr/bin/env bash

set -e

if [ -z "$(readlink $0)" ]
then
  dir=$(dirname $0)
else
  dir=$(dirname $0)/$(dirname $(readlink $0))
fi
libs=$dir/libs

fir_host=http://api.fir.im/apps
api_token=$(node $libs/get-config.js fir.fir_api_token)
ios_export_method=$(node $libs/get-config.js fir.ios_export_method)

sh $libs/build-android.sh

android_app=$(ls -l ./android/app/build/outputs/apk/release/*.apk | tail -n 1 | awk '{print $NF}')
apk_info=$(node $libs/apk-info.js $android_app)
eval "$apk_info"

sh $libs/archive.sh
sh $libs/export-ipa.sh $ios_export_method

ios_app=$(ls ./ios/build/ipa-${ios_export_method}/*.ipa)
ipa_info=$(node $libs/ipa-info.js $ios_app)
eval "$ipa_info"
# ios_name=
# ios_icon=
# ios_bundle=
# ios_code=
# ios_version=

# Android
if [ -n "$android_app" ]
then
  echo -e "\033[32m[fir.im] Getting android token...\033[0m"
  token_result=$(
    curl \
      --silent \
      --request "POST" \
      --header "Content-Type: application/json" \
      --data "{\"type\":\"android\", \"bundle_id\":\"$android_bundle\", \"api_token\":\"$api_token\"}" \
      ${fir_host}
  )
  token_log=$(node $libs/validate-fir-token.js "$token_result")
  eval "$token_log"
  # short_url=
  # binary_key=
  # binary_token=
  # binary_upload_url=
  # icon_key=
  # icon_token=
  # icon_upload_url=

  if [ -n "$android_icon" ]
  then
    echo -e "\033[32m[fir.im] Uploading android icon...\033[0m"
    result=$(
      curl \
        --silent \
        --form "file=@$android_icon" \
        --form "key=$icon_key" \
        --form "token=$icon_token" \
        ${icon_upload_url}
    )
    rm -f $android_icon
  fi

  echo -e "\033[32m[fir.im] Uploading android binary...\033[0m"
  result=$(
    curl \
      --form "file=@$android_app" \
      --form "key=$binary_key" \
      --form "token=$binary_token" \
      --form "x:name=$android_name" \
      --form "x:version=$android_version" \
      --form "x:build=$android_code" \
      --form "x:changelog=$(node $libs/changelog.js "$@")" \
      ${binary_upload_url}
  )
  node $libs/validate-fir.js "$result"
  echo -e "\n[fir.im] Download app by visit link: \033[32mhttps://fir.im/$short_url\033[0m\n"
else
  echo -e "\033[31m[fir.im] Android file is missing.\033[0m"
fi

# Ios
if [ -n "$ios_app" ]
then
  echo -e "\033[32m[fir.im] Getting ios token...\033[0m"
  token_result=$(
    curl \
      --silent \
      --request "POST" \
      --header "Content-Type: application/json" \
      --data "{\"type\":\"ios\", \"bundle_id\":\"$ios_bundle\", \"api_token\":\"$api_token\"}" \
      ${fir_host}
  )
  token_log=$(node $libs/validate-fir-token.js "$token_result")
  eval "$token_log"
  # short_url=
  # binary_key=
  # binary_token=
  # binary_upload_url=
  # icon_key=
  # icon_token=
  # icon_upload_url=

  if [ -n "$ios_icon" ]
  then
    echo -e "\033[32m[fir.im] Uploading ios icon...\033[0m"
    result=$(
      curl \
        --silent \
        --form "file=@$ios_icon" \
        --form "key=$icon_key" \
        --form "token=$icon_token" \
        ${icon_upload_url}
    )
    rm -f $ios_icon
  fi

  if [ "$ios_export_method" == "enterprise" ]
  then
    release_type=inhouse
  else
    release_type=adhoc
  fi

  echo -e "\033[32m[fir.im] Uploading ios binary to...\033[0m"
  result=$(
    curl \
      --form "file=@$ios_app" \
      --form "key=$binary_key" \
      --form "token=$binary_token" \
      --form "x:name=$ios_name" \
      --form "x:version=$ios_version" \
      --form "x:build=$ios_code" \
      --form "x:changelog=$(node $libs/changelog.js "$@")" \
      --form "x:release_type=$release_type" \
      ${binary_upload_url}
  )
  node $libs/validate-fir.js "$result"
  echo -e "\n[fir.im] Download app by visit link: \033[32mhttps://fir.im/$short_url\033[0m\n"
else
  echo -e "\033[31m[fir.im] Ios file is missing.\033[0m"
fi
