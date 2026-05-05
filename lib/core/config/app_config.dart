/// Static app-level configuration baked in at build time.
/// Set tenant via: flutter run --dart-define=TENANT_ID=tenant_abc
class AppConfig {
  AppConfig._();

  static const String tenantId = String.fromEnvironment(
    'TENANT_ID',
    defaultValue: 'tenant_abc',
  );
}
