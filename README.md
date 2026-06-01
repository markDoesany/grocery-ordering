# Grocery

Multi-tenant B2B grocery ordering mockup built with Flutter.

## Project Guide

Read [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) first. It explains the
folder structure, state management, navigation, and where new code should go.

## Useful Commands

```powershell
flutter analyze
flutter test
flutter run
```

## Environment Setup

This app reads API/auth configuration from Dart defines.

1. Create a local env file from [env/development.example.json](env/development.example.json).
2. Save it as `env/development.json`.
3. Run the app with:

```powershell
flutter run --dart-define-from-file=env/development.json
```

Keys used by the app:

- `API_BASE_URL`
- `API_LOGIN_PATH`
- `API_PRODUCTS_PATH`
- `API_LOGGING_ENABLED`
- `DEFAULT_TENANT_KEY`
- `DEFAULT_EMAIL`
- `DEFAULT_PASSWORD`

## Flutter References

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)
