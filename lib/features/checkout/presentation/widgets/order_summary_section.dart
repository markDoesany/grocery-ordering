import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/domain/cart_provider.dart';
import '../../../../shared/widgets/app_surface.dart';
import 'order_item_row.dart';
import 'price_row.dart';

/// Order summary card - cart line items + subtotal/tax/total breakdown.
class OrderSummarySection extends ConsumerWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final items = ref.watch(cartItemsProvider);
    final summary = ref.watch(cartSummaryProvider);

    return AppSurface(
      highlight: true,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDER SUMMARY',
            style: tt.headlineSmall?.copyWith(color: cs.primary),
          ),
          const SizedBox(height: 4),
          Divider(height: 1, thickness: 1, color: cs.outline),
          const SizedBox(height: 16),
          if (items.isEmpty)
            Text(
              'No items selected.',
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            )
          else
            for (final item in items) ...[
              OrderItemRow(
                name: item.product.name,
                quantity: '${item.quantity}',
                price: '₱${item.lineTotal.toStringAsFixed(2)}',
              ),
              if (item != items.last) const SizedBox(height: 8),
            ],
          const SizedBox(height: 16),
          Divider(height: 2, thickness: 2, color: cs.primary),
          const SizedBox(height: 8),
          PriceRow(label: 'Subtotal', value: summary.formattedSubtotal),
          const SizedBox(height: 4),
          PriceRow(label: 'Tax', value: summary.formattedTax),
          const SizedBox(height: 8),
          Divider(height: 1, thickness: 1, color: cs.outlineVariant),
          const SizedBox(height: 8),
          PriceRow(
            label: 'Total',
            value: summary.formattedTotal,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}
