import 'package:flutter/material.dart';
import '../domain/branding_model.dart';

/// Returns mocked branding per tenant.
/// Replace the switch body with a Dio call when /branding endpoint is ready.
class BrandingRepository {
  const BrandingRepository();

  Future<BrandingModel> fetchBranding(String tenantId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return switch (tenantId) {
      'tenant_abc' => BrandingModel(
        tenantId: tenantId,
        primaryColor: const Color(0xFF1B5E20),
        secondaryColor: const Color(0xFFA5D6A7),
        logoAssetPath: 'assets/images/logo_default.png',
        displayName: 'ABC Grocery Supply',
      ),
      _ => BrandingModel(
        tenantId: tenantId,
        primaryColor: const Color(0xFF0D47A1),
        secondaryColor: const Color(0xFF90CAF9),
        logoAssetPath: 'assets/images/logo_default.png',
        displayName: 'Grocery Supplier',
      ),
    };
  }
}
