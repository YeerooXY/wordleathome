# Our Word on phones

The web game works on iPhone and Android. The native packages open the same hosted game in a system browser view: SFSafariViewController on iOS, Custom Tabs on Android. This preserves the platform's ChatGPT sign-in flow and household sessions. System browser controls remain available; these are small native hosts, not a separately implemented offline game. The deployed app must allow household visitors before family members can sign in.

## SideStore IPA

The iOS host targets iOS 15+ and uses only system frameworks, one bundle ID, and no special entitlements or extensions. A paid Apple Developer membership and signing credentials are not needed for this build. SideStore re-signs the result on the phone using the user's Apple Account.

On a Mac with Xcode and XcodeGen:

```sh
brew install xcodegen
bash mobile/ios/build-sidestore.sh
```

Output: `mobile/ios/build/OurWord-SideStore.ipa`.

Alternatively, put these files in a GitHub repository and run **Build SideStore IPA and Android APK**. The workflow's macOS job builds and packages the device executable without Apple secrets. Download the `OurWord-SideStore` artifact, extract its IPA, then import that IPA through SideStore. This source project is not itself an IPA; do not rename a source ZIP and expect it to run.

SideStore's [official installation guide](https://docs.sidestore.io/docs/installation/install) and [FAQ](https://docs.sidestore.io/docs/faq) describe setup, signing, refreshes, and free-account limits. Device installation must still be tested after building. No IPA has been claimed as built until the workflow or Xcode completes successfully.

## Android APK

The project targets Android 8+ and uses AndroidX Custom Tabs. On a machine with JDK 17+, Gradle 8.11.1, and Android SDK 35:

```sh
cd mobile/android
gradle assembleDebug
```

Output: `mobile/android/app/build/outputs/apk/debug/app-debug.apk`. The GitHub workflow builds the same installable debug APK. This is intended for household sideloading, not a signed Play Store release.

## Home screen installation

The web version also includes an install manifest, phone icons, safe-area layout, and an offline reconnect screen. iPhone: open the deployed site in Safari and use Share → Add to Home Screen. Android: use the browser's Install app / Add to Home screen action. An internet connection is needed for guesses, shared scores, and live letters. No private gameplay or sign-in responses are stored in the service-worker cache.
