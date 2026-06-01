import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/providers/catalog_provider.dart';
import '../../../../../shared/widgets/section_header.dart';
import 'frequently_purchased_card.dart';

/// Horizontally-scrollable row of frequently purchased items.
class FrequentlyPurchasedSection extends ConsumerWidget {
  const FrequentlyPurchasedSection({super.key, this.onSeeAll, this.onAdd});

  final VoidCallback? onSeeAll;
  final ValueChanged<String>? onAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final productsAsync = ref.watch(catalogProvider);

    return productsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
      data: (allProducts) {
        final products = allProducts.take(4).toList(growable: false);
        if (products.isEmpty) return const SizedBox.shrink();

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
      },
    );
  }
}
