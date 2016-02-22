#!/bin/bash
cd $(dirname ${0})

PRODUCT_NAME='RollBall'
IOS_PROJ='iOSProj'
IDENTIFIER_PREFIX="com.larryhou.samples"

if [ -d "${IOS_PROJ}" ]
then
	rm -fr "${IOS_PROJ}"
fi

mkdir "${IOS_PROJ}"

# Export unity project to xcode project
# ExportTool.ExportXcodeProject is defined in [Assets/Editor/ExportTool.cs]
/Applications/Unity/Unity.app/Contents/MacOS/Unity -batchmode -quit -projectPath "${PWD}" -executeMethod ExportTool.ExportXcodeProject -logFile "${PWD}/${IOS_PROJ}/export.log"

# Update PRODUCT_NAME
sed -i '' "s/PRODUCT_NAME\ =\ ProductName/PRODUCT_NAME\ =\ ${PRODUCT_NAME}/g" "${IOS_PROJ}/Unity-iPhone.xcodeproj/project.pbxproj"

# Update PRODUCT_BUNDLE_IDENTIFIER
sed -i '' "s/com.Company.\${PRODUCT_NAME}/${IDENTIFIER_PREFIX}.\${PRODUCT_NAME}/g" "${IOS_PROJ}/Info.plist"

# Build for *.app
# CODE_SIGN_IDENTITY="iPhone Developer" 
xcodebuild -project "${IOS_PROJ}/Unity-iPhone.xcodeproj"

# Package for *.ipa
xcrun -sdk iphoneos PackageApplication -v "${PWD}/${IOS_PROJ}/build/Release-iphoneos/${PRODUCT_NAME}.app" -o "${PWD}/${IOS_PROJ}/${PRODUCT_NAME}.ipa"