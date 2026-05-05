import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../features/cart/domain/cart_provider.dart';
import '../../../shared/utils/mock_actions.dart';
import '../../../shared/widgets/app_scroll_view.dart';
import '../../../shared/widgets/mobile_scaffold.dart';
import '../../../shared/widgets/section_header.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/ledger_total_section.dart';

/// Active cart / ledger screen.
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final cartItems = ref.watch(cartItemsProvider);
    final summary = ref.watch(cartSummaryProvider);
    final cart = ref.read(cartProvider.notifier);

    return MobileScaffold(
      currentTab: AppTab.cart,
      cartSummary: summary,
      backgroundColor: cs.surface,
      appBar: _CartAppBar(
        onClear: summary.itemCount > 0
            ? cart.clear
            : () => showMockSnack(context, 'Cart is already empty'),
      ),
      bottom: LedgerTotalSection(
        subtotal: summary.formattedSubtotal,
        tax: summary.formattedTax,
        total: summary.formattedTotal,
        onCheckout: summary.itemCount > 0
            ? () => context.go(AppConstants.checkoutRoute)
            : () => showMockSnack(context, 'Add items before checkout'),
      ),
      body: AppScrollView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Active Ledger', usePrimaryBorder: true),
          const SizedBox(height: 8),
          if (cartItems.isEmpty)
            const _EmptyCart()
          else
            for (final item in cartItems) ...[
              CartItemCard(
                name: item.product.name,
                description: '${item.product.category}  •  ${item.product.sku}',
                price: item.product.formattedPrice,
                quantity: item.quantity,
                onDecrement: () => cart.decrement(item.product.id),
                onIncrement: () => cart.increment(item.product.id),
                onRemove: () => cart.remove(item.product.id),
              ),
              if (item != cartItems.last) const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(border: Border.all(color: cs.outlineVariant)),
      child: Column(
        children: [
          Icon(Icons.shopping_cart_outlined, size: 40, color: cs.outline),
          const SizedBox(height: 12),
          Text(
            'Your cart is empty',
            style: tt.headlineSmall?.copyWith(color: cs.onSurface),
          ),
          const SizedBox(height: 4),
          Text(
            'Add products from Restock or Search to build an order.',
            textAlign: TextAlign.center,
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CartAppBar({this.onClear});

  final VoidCallback? onClear;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(bottom: BorderSide(color: cs.primary, width: 2)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'MY CART',
                  style: tt.headlineMedium?.copyWith(color: cs.primary),
                ),
              ),
              IconButton(
                onPressed: onClear,
                icon: Icon(Icons.delete_outline, color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
