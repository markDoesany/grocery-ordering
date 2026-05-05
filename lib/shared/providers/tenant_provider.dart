import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tenant_model.dart';

/// Single source of truth for the active tenant.
/// Null before splash completes. Set exactly once during bootstrapping.
final tenantProvider = StateProvider<TenantModel?>((ref) => null);
