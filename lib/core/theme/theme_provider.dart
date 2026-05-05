import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/branding/domain/branding_provider.dart';
import 'app_theme.dart';

/// Derived from brandingProvider — never mutated directly.
/// Returns fallback theme while branding is loading or on error.
final themeProvider = Provider<ThemeData>((ref) {
  final brandingAsync = ref.watch(brandingProvider);
  return brandingAsync.when(
    data: AppTheme.fromBranding,
    loading: () => AppTheme.fallback,
    error: (err, _) => AppTheme.fallback,
  );
});
