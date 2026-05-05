import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/app_config.dart';
import '../data/branding_repository.dart';
import 'branding_model.dart';

final brandingRepositoryProvider = Provider<BrandingRepository>(
  (_) => const BrandingRepository(),
);

/// Fetched once at splash, cached by Riverpod for all subsequent watchers.
final brandingProvider = FutureProvider<BrandingModel>((ref) {
  final repo = ref.read(brandingRepositoryProvider);
  return repo.fetchBranding(AppConfig.tenantId);
});
