import 'package:dio/dio.dart';
import '../../core/config/app_config.dart';
import '../models/product_model.dart';

class CatalogRepository {
  const CatalogRepository(this._dio);

  final Dio _dio;

  Future<List<ProductModel>> fetchProducts({
    required String authorizationHeader,
  }) async {
    final response = await _dio.get<dynamic>(
      AppConfig.productsPath,
      options: Options(headers: {'Authorization': authorizationHeader}),
    );

    final payload = response.data;
    final items = switch (payload) {
      {'data': final List<dynamic> data} => data,
      List<dynamic> data => data,
      _ => const <dynamic>[],
    };

    return items
        .whereType<Map<String, dynamic>>()
        .map(_mapProduct)
        .toList(growable: false);
  }

  ProductModel _mapProduct(Map<String, dynamic> json) {
    final rawId = json['external_id'] ?? json['sku'] ?? json['id'];
    final sku = (json['sku'] ?? '').toString();
    final priceValue = json['price'];
    final stockQuantityValue = json['stock_quantity'];

    final stockQuantity = switch (stockQuantityValue) {
      int value => value,
      String value => int.tryParse(value) ?? 0,
      _ => 0,
    };

    final price = switch (priceValue) {
      int value => value.toDouble(),
      double value => value,
      String value => double.tryParse(value) ?? 0,
      _ => 0.0,
    };

    return ProductModel(
      id: (rawId ?? sku).toString(),
      name: (json['name'] ?? 'Unnamed Product').toString(),
      category: 'General',
      sku: sku.isNotEmpty ? sku : (rawId ?? '').toString(),
      price: price,
      stockStatus: _stockStatusFromQuantity(stockQuantity),
      badge: stockQuantity == 0
          ? 'Wala na'
          : stockQuantity <= 20
          ? 'Mababa na'
          : null,
    );
  }

  String _stockStatusFromQuantity(int stockQuantity) {
    if (stockQuantity <= 0) return 'out';
    if (stockQuantity <= 20) return 'low';
    return 'ok';
  }
}
