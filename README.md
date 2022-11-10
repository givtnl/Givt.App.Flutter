# givt_mobile_apps

What are the requirements to get started?
How should i build this application?

To generate JSON serializable classes:
flutter pub run build_runner build --delete-conflicting-outputs

To generate new realms schema
flutter pub run realm generate

(DevTools)[https://docs.flutter.dev/development/tools/devtools/overview] is a suite of performance and debugging tools for Dart and Flutter.

To build new images for the native splash screens for both android and iOS:
  flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml 