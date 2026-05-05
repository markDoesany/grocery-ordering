import 'package:flutter/material.dart';

class BrandingModel {
  const BrandingModel({
    required this.tenantId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.logoAssetPath,
    required this.displayName,
  });

  final String tenantId;
  final Color primaryColor;
  final Color secondaryColor;
  final String logoAssetPath;
  final String displayName;
}
