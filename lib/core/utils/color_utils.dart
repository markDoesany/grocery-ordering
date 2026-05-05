import 'package:flutter/material.dart';

class ColorUtils {
  ColorUtils._();

  /// Parses a hex color string like '#1B5E20' or '1B5E20'.
  static Color fromHex(String hex, {Color fallback = const Color(0xFF000000)}) {
    final cleaned = hex.replaceFirst('#', '');
    if (cleaned.length != 6 && cleaned.length != 8) return fallback;
    final value = int.tryParse(
      cleaned.length == 6 ? 'FF$cleaned' : cleaned,
      radix: 16,
    );
    return value != null ? Color(value) : fallback;
  }
}
