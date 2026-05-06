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
    // Beverages
    ProductModel(
      id: 'sku-001',
      name: 'Nescafé 3-in-1 Original',
      category: 'Beverages',
      sku: 'SKU-001',
      price: 8.50,
      packSize: 'Kahon ng 30',
      badge: 'SALE',
    ),
    ProductModel(
      id: 'sku-002',
      name: 'Milo Activ-Go Sachet',
      category: 'Beverages',
      sku: 'SKU-002',
      price: 9.75,
      packSize: 'Pack ng 20',
    ),
    ProductModel(
      id: 'sku-003',
      name: 'C2 Apple Green Tea',
      category: 'Beverages',
      sku: 'SKU-003',
      price: 20.00,
      stockStatus: 'low',
      badge: 'Mababa na',
    ),

    // Canned goods / Pantry
    ProductModel(
      id: 'sku-004',
      name: 'Ligo Sardines sa Tomato Sauce',
      category: 'Canned Goods',
      sku: 'SKU-004',
      price: 27.50,
      packSize: 'Kahon ng 24',
      badge: 'SALE',
    ),
    ProductModel(
      id: 'sku-005',
      name: 'Argentina Corned Beef 150g',
      category: 'Canned Goods',
      sku: 'SKU-005',
      price: 55.00,
      packSize: 'Kahon ng 12',
    ),
    ProductModel(
      id: 'sku-006',
      name: 'Lucky Me! Pancit Canton',
      category: 'Canned Goods',
      sku: 'SKU-006',
      price: 14.00,
      stockStatus: 'low',
      badge: 'Mababa na',
    ),

    // Staples
    ProductModel(
      id: 'sku-007',
      name: 'Sinandomeng Rice 1kg',
      category: 'Bigas at Pampalasa',
      sku: 'SKU-007',
      price: 58.00,
    ),
    ProductModel(
      id: 'sku-008',
      name: 'Datu Puti Toyo 1L',
      category: 'Bigas at Pampalasa',
      sku: 'SKU-008',
      price: 42.00,
    ),
    ProductModel(
      id: 'sku-009',
      name: 'Golden Fiesta Palm Oil 1L',
      category: 'Bigas at Pampalasa',
      sku: 'SKU-009',
      price: 89.00,
      stockStatus: 'low',
      badge: 'Mababa na',
    ),

    // Snacks
    ProductModel(
      id: 'sku-010',
      name: 'Oishi Prawn Crackers',
      category: 'Meryenda',
      sku: 'SKU-010',
      price: 12.00,
      packSize: 'Pack ng 10',
    ),
    ProductModel(
      id: 'sku-011',
      name: 'Sky Flakes Crackers',
      category: 'Meryenda',
      sku: 'SKU-011',
      price: 8.00,
      packSize: 'Pack ng 10',
    ),

    // Household / Personal care
    ProductModel(
      id: 'sku-012',
      name: 'Ariel Detergent Sachet',
      category: 'Panlinis',
      sku: 'SKU-012',
      price: 10.00,
      packSize: 'Pack ng 24',
    ),
    ProductModel(
      id: 'sku-013',
      name: 'Safeguard Bar Soap 135g',
      category: 'Panlinis',
      sku: 'SKU-013',
      price: 32.00,
    ),
    ProductModel(
      id: 'sku-014',
      name: 'Palmolive Shampoo Sachet',
      category: 'Panlinis',
      sku: 'SKU-014',
      price: 7.50,
      packSize: 'Pack ng 24',
      stockStatus: 'out',
    ),
  ];

  static const promotions = [
    PromotionModel(
      badge: 'Linggo ng Deal',
      headline: 'Fast movers ngayong linggo',
      subtext: 'Mag-stock na bago maubusan. Sardinas, kape, at instant noodles sa pinakamababang presyo.',
      actionLabel: 'Mag-order na',
      filled: true,
    ),
    PromotionModel(
      badge: 'Bagong Dating',
      headline: 'Fresh mula sa supplier',
      subtext: 'Dumating na ang bagong bundle ng shampoo at detergent sachets.',
      actionLabel: 'Tingnan',
      filled: false,
    ),
    PromotionModel(
      badge: 'Bulk Deal',
      headline: 'Mas mura kapag marami',
      subtext: 'Bumili ng kahon ng sardinas o kape — mas mataas ang kita sa bawat piraso.',
      actionLabel: 'Suriin',
      filled: true,
    ),
  ];

  static const initialCartQuantities = {
    'sku-001': 3,
    'sku-004': 2,
    'sku-007': 1,
  };

  /// Products currently in the quick-reorder history (last order).
  static List<ProductModel> get quickReorderProducts => [
    byId('sku-001'),
    byId('sku-004'),
    byId('sku-007'),
    byId('sku-012'),
    byId('sku-010'),
  ];

  /// Products flagged as low or out of stock.
  static List<ProductModel> get lowStockProducts =>
      products.where((p) => p.isLowStock || p.isOutOfStock).toList();

  static ProductModel byId(String id) {
    return products.firstWhere((product) => product.id == id);
  }
}
