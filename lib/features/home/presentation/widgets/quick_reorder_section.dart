import 'package:flutter/material.dart';
import '../../../../shared/data/mock_catalog.dart';
import '../../../../shared/widgets/section_header.dart';
import 'quick_reorder_item_card.dart';

/// Horizontal scroll row of recently ordered items with inline steppers.
class QuickReorderSection extends StatelessWidget {
  const QuickReorderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final products = MockCatalog.quickReorderProducts;

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
  }
}
