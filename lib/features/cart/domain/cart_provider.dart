import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/data/mock_catalog.dart';
import '../../../shared/models/product_model.dart';
import '../../../shared/providers/catalog_provider.dart';

final cartProvider = StateNotifierProvider<CartController, Map<String, int>>((
  ref,
) {
  return CartController();
});

final cartItemsProvider = Provider<List<CartItem>>((ref) {
  final quantities = ref.watch(cartProvider);
  final catalog = ref
      .watch(catalogProvider)
      .maybeWhen(
        data: (products) => products,
        orElse: () => MockCatalog.products,
      );
  final productsById = {for (final product in catalog) product.id: product};
  final items = <CartItem>[];

  for (final entry in quantities.entries) {
    if (entry.value <= 0) continue;
    final product = productsById[entry.key];
    if (product == null) continue;
    items.add(CartItem(product: product, quantity: entry.value));
  }

  return items;
});

final cartSummaryProvider = Provider<CartSummary>((ref) {
  final items = ref.watch(cartItemsProvider);
  final subtotal = items.fold<double>(
    0,
    (total, item) => total + item.lineTotal,
  );
  final tax = subtotal * 0.08;
  return CartSummary(
    itemCount: items.fold<int>(0, (total, item) => total + item.quantity),
    subtotal: subtotal,
    tax: tax,
    total: subtotal + tax,
  );
});

class CartController extends StateNotifier<Map<String, int>> {
  CartController() : super({});

  void setQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      remove(productId);
      return;
    }
    state = {...state, productId: quantity};
  }

  void increment(String productId) {
    setQuantity(productId, (state[productId] ?? 0) + 1);
  }

  void decrement(String productId) {
    setQuantity(productId, (state[productId] ?? 0) - 1);
  }

  void remove(String productId) {
    final next = {...state}..remove(productId);
    state = next;
  }

  void clear() => state = {};
}

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;

  double get lineTotal => product.price * quantity;
}

class CartSummary {
  const CartSummary({
    required this.itemCount,
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  final int itemCount;
  final double subtotal;
  final double tax;
  final double total;

  String get badgeText => itemCount.toString();
  String get formattedSubtotal => _formatMoney(subtotal);
  String get formattedTax => _formatMoney(tax);
  String get formattedTotal => _formatMoney(total);

  static String _formatMoney(double value) => '₱${value.toStringAsFixed(2)}';
}
