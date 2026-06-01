import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/catalog_provider.dart';
import '../../../../shared/widgets/section_header.dart';
import 'quick_reorder_item_card.dart';

/// Horizontal scroll row of recently ordered items with inline steppers.
class QuickReorderSection extends ConsumerWidget {
  const QuickReorderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(catalogProvider);

    return productsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
      data: (allProducts) {
        if (allProducts.isEmpty) return const SizedBox.shrink();
        final products = allProducts.take(5).toList(growable: false);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Mag-reorder'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final product in products) ...[
                    QuickReorderItemCard(
                      productId: product.id,
                      name: product.name,
                      price: product.formattedPrice,
                      badge: product.badge == 'SALE' ? 'Sale' : null,
                    ),
                    if (product != products.last) const SizedBox(width: 10),
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
