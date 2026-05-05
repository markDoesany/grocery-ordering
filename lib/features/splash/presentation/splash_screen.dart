import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/app_constants.dart';
import '../../../features/branding/domain/branding_model.dart';
import '../../../features/branding/domain/branding_provider.dart';
import '../../../shared/models/tenant_model.dart';
import '../../../shared/providers/tenant_provider.dart';
import '../../../shared/widgets/loading_indicator.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // Run branding fetch and minimum display time concurrently.
    late final BrandingModel branding;
    await Future.wait([
      ref.read(brandingProvider.future).then((b) => branding = b),
      Future.delayed(AppConstants.splashMinDuration),
    ]);

    ref.read(tenantProvider.notifier).state = TenantModel(
      tenantId: AppConfig.tenantId,
      tenantName: branding.displayName,
      supplierName: branding.displayName,
    );

    if (mounted) context.go(AppConstants.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1B5E20),
      body: LoadingIndicator(color: Colors.white),
    );
  }
}
