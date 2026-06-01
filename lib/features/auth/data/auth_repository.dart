import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../domain/auth_session.dart';

class AuthRepository {
  const AuthRepository(this._dio);

  final Dio _dio;

  Future<AuthSession> login({
    required String tenantKey,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<dynamic>(
      AppConfig.loginPath,
      data: {'tenant_key': tenantKey, 'email': email, 'password': password},
    );

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw const FormatException('Invalid login response format.');
    }

    final token = (body['token'] ?? '').toString();
    if (token.isEmpty) {
      throw const FormatException('Login response missing token.');
    }

    final tenant = body['tenant'];
    final merchant = body['merchant'];

    return AuthSession(
      token: token,
      tokenType: (body['token_type'] ?? 'Bearer').toString(),
      tenantId: tenant is Map<String, dynamic>
          ? (tenant['id'] ?? '').toString()
          : '',
      merchantName: merchant is Map<String, dynamic>
          ? (merchant['name'] ?? '').toString()
          : '',
      ownerName: merchant is Map<String, dynamic>
          ? (merchant['owner_name'] ?? '').toString()
          : '',
      email: merchant is Map<String, dynamic>
          ? (merchant['email'] ?? email).toString()
          : email,
    );
  }
}
