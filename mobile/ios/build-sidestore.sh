#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
if ! command -v xcodebuild >/dev/null; then
  echo 'This build requires macOS and Xcode. Use the native-builds GitHub workflow.' >&2
  exit 1
fi
if ! command -v xcodegen >/dev/null; then
  echo 'Install XcodeGen first: brew install xcodegen' >&2
  exit 1
fi
xcodegen generate
xcodebuild -project OurWord.xcodeproj -scheme OurWord -configuration Release \
  -destination 'generic/platform=iOS' -archivePath build/OurWord.xcarchive \
  CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO archive
mkdir -p build/package/Payload
ditto build/OurWord.xcarchive/Products/Applications/OurWord.app build/package/Payload/OurWord.app
# An ad-hoc signature supplies bundle hashes; SideStore replaces it with the
# user's personal certificate. No Apple ID or signing secret is used to build.
codesign --force --sign - build/package/Payload/OurWord.app
cd build/package
ditto -c -k --keepParent Payload ../OurWord-SideStore.ipa
echo 'Created mobile/ios/build/OurWord-SideStore.ipa. Install it through SideStore.'
