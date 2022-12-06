# Givt.App.Flutter
A brief description

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [DevTools](https://docs.flutter.dev/development/tools/devtools/overview), a suite of performance and debugging tools for Dart and Flutter.

## Getting started
How should i build this application?

## Usefull Commands

To generate JSON serializable classes:
```shell
flutter pub run build_runner build --delete-conflicting-outputs
```

To generate new realms schema:
```shell
flutter pub run realm generate
```
To build new images for the native splash screens for both android and iOS:
```shell
flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml 
```

## Pipeline work documentation:
- Oct 28 Maarten finished successfully setting up fastlane. Core of it are the fast files (android/fastlane/Fastfile) & (ios/fastlane/Fastfile)   [Maarten's documentation video on slack](https://nfcollect.slack.com/files/U14JJU34J/F048FDEE1B6/flutter_-_fastlane_-_codesigning_-_ci.mkv)
- Nov 9 the ios upload to testflight started failing. The errors returned by fastlane were: 'Transporter transfer failed.' and 'Error uploading ipa file'. There is an open [issue](https://github.com/fastlane/fastlane/issues/20879) on the fastlane repo that seems to match our problem. [here](https://github.com/fastlane/fastlane/issues/20879) -- there is potential fix  commented yesterday(nov 30)!! But it was not yet tried out (dec 1).
- The current(dec 1) workaround we created is removing the responsability of 'uploading the ipa file' from fastlane since that is the only step that fails and it can be done manually so we arent totally stuck without ios releases.
So now the ios fastfile releases the ipa from the pipeline to github, from there it can be manually downloaded and uploaded to testflight. You can find the realeases [here](https://github.com/givtnl/Givt.App.Flutter/releases)
- Now there is also a separate github actions workflow that is triggered if the fastlane ios build & release were successful: '.github/workflows/ios-upload-testflight.yml'. It is also currently failing(dec 1), it is an action from the marketplace, might be deprecated.