import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_client.dart';
import '../../features/auth/domain/auth_provider.dart';
import '../data/catalog_repository.dart';
import '../data/mock_catalog.dart';
import '../models/product_model.dart';

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepository(ref.read(apiClientProvider));
});

final catalogProvider = FutureProvider<List<ProductModel>>((ref) async {
  final session = ref.watch(authSessionProvider);
  if (session == null) return MockCatalog.products;

  final products = await ref
      .read(catalogRepositoryProvider)
      .fetchProducts(authorizationHeader: session.authorizationHeader);

  if (products.isEmpty) return MockCatalog.products;
  return products;
});
