class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.sku,
    required this.price,
    this.badge,
    this.stockStatus = 'ok',
    this.packSize,
  });

  final String id;
  final String name;
  final String category;
  final String sku;
  final double price;
  final String? badge;

  /// 'ok' | 'low' | 'out'
  final String stockStatus;

  /// Supplier pack size label, e.g. 'Dose ng 12', 'Pack of 6'
  final String? packSize;

  bool get isLowStock => stockStatus == 'low';
  bool get isOutOfStock => stockStatus == 'out';

  String get formattedPrice => '₱${price.toStringAsFixed(2)}';
}
