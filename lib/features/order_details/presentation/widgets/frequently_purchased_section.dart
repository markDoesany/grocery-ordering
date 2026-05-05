import 'package:flutter/material.dart';
import '../../../../../shared/data/mock_catalog.dart';
import '../../../../../shared/widgets/section_header.dart';
import 'frequently_purchased_card.dart';

/// Horizontally-scrollable row of frequently purchased items.
class FrequentlyPurchasedSection extends StatelessWidget {
  const FrequentlyPurchasedSection({super.key, this.onSeeAll, this.onAdd});

  final VoidCallback? onSeeAll;
  final ValueChanged<String>? onAdd;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final products = MockCatalog.products.take(4).toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Frequently Purchased',
          trailing: GestureDetector(
            onTap: onSeeAll,
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
                FrequentlyPurchasedCard(
                  name: product.name,
                  price: product.formattedPrice,
                  onAdd: () => onAdd?.call(product.id),
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
