import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../data/auth_repository.dart';
import 'auth_session.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(apiClientProvider));
});

final authSessionProvider = StateProvider<AuthSession?>((_) => null);

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
      return AuthController(ref);
    });

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._ref) : super(const AsyncData(null));

  final Ref _ref;

  Future<void> login({
    required String tenantKey,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = await _ref
          .read(authRepositoryProvider)
          .login(tenantKey: tenantKey, email: email, password: password);
      _ref.read(authSessionProvider.notifier).state = session;
    });
  }

  void logout() {
    _ref.read(authSessionProvider.notifier).state = null;
    state = const AsyncData(null);
  }
}
