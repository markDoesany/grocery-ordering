import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/cart/domain/cart_provider.dart';
import '../../../../shared/data/mock_catalog.dart';
import '../../../../shared/utils/mock_actions.dart';
import '../../../../shared/widgets/section_header.dart';
import 'quick_reorder_item_card.dart';

/// Horizontal scroll row of recently ordered items.
class QuickReorderSection extends ConsumerWidget {
  const QuickReorderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final products = MockCatalog.products.take(4).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Quick Reorder',
          trailing: GestureDetector(
            onTap: () => showMockActionSheet(
              context,
              title: 'Quick reorder',
              options: const ['Last order', 'Most purchased', 'Sale repeats'],
            ),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'SEE ALL',
                style: tt.labelLarge?.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              for (final product in products) ...[
                QuickReorderItemCard(
                  name: product.name,
                  price: product.formattedPrice,
                  badge: product.badge == 'SALE' ? 'NEW' : null,
                  onActionTap: () =>
                      ref.read(cartProvider.notifier).increment(product.id),
                ),
                if (product != products.last) const SizedBox(width: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
