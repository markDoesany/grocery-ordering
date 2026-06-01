class AuthSession {
  const AuthSession({
    required this.token,
    required this.tokenType,
    required this.tenantId,
    required this.merchantName,
    required this.ownerName,
    required this.email,
  });

  final String token;
  final String tokenType;
  final String tenantId;
  final String merchantName;
  final String ownerName;
  final String email;

  String get authorizationHeader => '$tokenType $token';
}
