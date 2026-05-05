import '../models/product_model.dart';

class PromotionModel {
  const PromotionModel({
    required this.badge,
    required this.headline,
    required this.subtext,
    required this.actionLabel,
    this.filled = true,
  });

  final String badge;
  final String headline;
  final String subtext;
  final String actionLabel;
  final bool filled;
}

class InventoryProduct {
  const InventoryProduct({
    required this.product,
    required this.onHand,
    required this.status,
  });

  final ProductModel product;
  final int onHand;
  final String status;
}

class MockCatalog {
  const MockCatalog._();

  static const products = [
    ProductModel(
      id: 'sku-001',
      name: 'Canned Sardines',
      category: 'Pantry',
      sku: 'SKU-001',
      price: 27.50,
      badge: 'SALE',
    ),
    ProductModel(
      id: 'sku-002',
      name: 'Instant Coffee',
      category: 'Beverages',
      sku: 'SKU-002',
      price: 8.75,
    ),
    ProductModel(
      id: 'sku-003',
      name: 'Laundry Sachet',
      category: 'Household',
      sku: 'SKU-003',
      price: 12.00,
      badge: 'Low Stock',
    ),
    ProductModel(
      id: 'sku-004',
      name: 'Rice Pack 1kg',
      category: 'Staples',
      sku: 'SKU-004',
      price: 58.25,
    ),
  ];

  static const promotions = [
    PromotionModel(
      badge: 'Weekly Deal',
      headline: 'Fast-moving staples',
      subtext: 'Restock essentials before the weekend rush.',
      actionLabel: 'Order Now',
      filled: true,
    ),
    PromotionModel(
      badge: 'New Arrival',
      headline: 'Fresh supplier picks',
      subtext: 'Add new sachet bundles to your regular shelf set.',
      actionLabel: 'Learn More',
      filled: false,
    ),
    PromotionModel(
      badge: 'Limited',
      headline: 'Bulk savings window',
      subtext: 'Lock in pricing on selected pantry goods today.',
      actionLabel: 'View Details',
      filled: true,
    ),
  ];

  static const initialCartQuantities = {
    'sku-001': 2,
    'sku-002': 1,
    'sku-003': 3,
  };

  static ProductModel byId(String id) {
    return products.firstWhere((product) => product.id == id);
  }
}
