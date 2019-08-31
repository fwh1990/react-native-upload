#!/usr/bin/env bash

# Variable EXPORT_METHOD can be one of [app-store, ad-hoc]
EXPORT_METHOD=$1

#TEAM_ID=$(cat ios/*.xcodeproj/project.pbxproj | grep DEVELOPMENT_TEAM | head -n 1 | awk '{print $NF}' | tr -d ';')
TEAM_ID_LINE=$(($(cat ios/build/archive.xcarchive/Info.plist | grep  -n  Team | cut -d: -f1) + 1))
TEAM_ID=$(sed -n "${TEAM_ID_LINE}p" ./ios/build/archive.xcarchive/Info.plist | cut -d'>' -f2 | cut -d'<' -f1)

export_option_file=/tmp/react-native-upload-ios-export_$$.plist

cat > $export_option_file <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>destination</key>
	<string>export</string>
	<key>method</key>
	<string>$EXPORT_METHOD</string>
	<key>signingStyle</key>
	<string>automatic</string>
	<key>stripSwiftSymbols</key>
	<true/>
	<key>teamID</key>
	<string>$TEAM_ID</string>
</dict>
</plist>
EOF

mkdir -p ./ios/build/ipa-${EXPORT_METHOD}
rm -rf ./ios/build/ipa-${EXPORT_METHOD}

# Export
# The same as Xcode -> Window -> Organizer -> Export
xcodebuild -exportArchive \
  -archivePath ./ios/build/archive.xcarchive \
  -exportPath ./ios/build/ipa-${EXPORT_METHOD} \
  -exportOptionsPlist $export_option_file \
  -allowProvisioningUpdates

rm -f $export_option_file
