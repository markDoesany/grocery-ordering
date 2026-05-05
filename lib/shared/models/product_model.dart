class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.sku,
    required this.price,
    this.badge,
  });

  final String id;
  final String name;
  final String category;
  final String sku;
  final double price;
  final String? badge;

  String get formattedPrice => '₱${price.toStringAsFixed(2)}';
}
