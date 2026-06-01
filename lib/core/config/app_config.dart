/// Static app-level configuration baked in at build time.
/// Override values via --dart-define or --dart-define-from-file.
class AppConfig {
  AppConfig._();

  static const String tenantId = String.fromEnvironment(
    'TENANT_ID',
    defaultValue: 'tenant_abc',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://one-solution-main-mo8dn4.laravel.cloud',
  );

  static const String loginPath = String.fromEnvironment(
    'API_LOGIN_PATH',
    defaultValue: '/api/v1/modules/grocery-connect/login',
  );

  static const String productsPath = String.fromEnvironment(
    'API_PRODUCTS_PATH',
    defaultValue: '/api/v1/modules/grocery-connect/products',
  );

  static const String defaultTenantKey = String.fromEnvironment(
    'DEFAULT_TENANT_KEY',
    defaultValue: 'abc',
  );

  static const String defaultEmail = String.fromEnvironment(
    'DEFAULT_EMAIL',
    defaultValue: 'bert@mail.com',
  );

  static const String defaultPassword = String.fromEnvironment(
    'DEFAULT_PASSWORD',
    defaultValue: 'password',
  );

  static const bool apiLoggingEnabled = bool.fromEnvironment(
    'API_LOGGING_ENABLED',
    defaultValue: true,
  );
}
