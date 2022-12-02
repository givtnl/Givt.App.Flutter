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