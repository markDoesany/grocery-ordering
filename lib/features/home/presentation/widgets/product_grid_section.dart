import 'package:flutter/material.dart';
import '../../../../shared/data/mock_catalog.dart';
import '../../../../shared/utils/mock_actions.dart';
import '../../../../shared/widgets/section_header.dart';
import 'product_card.dart';

/// Responsive product grid with a section header and filter button.
class ProductGridSection extends StatelessWidget {
  const ProductGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'All Products',
          large: true,
          usePrimaryBorder: true,
          trailing: Material(
            color: cs.surfaceContainerLowest,
            child: InkWell(
              onTap: () => showMockActionSheet(
                context,
                title: 'Product filters',
                options: const ['Sort by demand', 'Sale items', 'Low stock'],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: cs.outline),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'FILTER',
                      style: tt.labelLarge?.copyWith(color: cs.onSurface),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.filter_list, size: 18, color: cs.onSurface),
                  ],
                ),
              ),
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 560 ? 3 : 2;
            final aspectRatio = switch (constraints.maxWidth) {
              < 340 => 0.52,
              < 560 => 0.62,
              _ => 0.68,
            };
            return GridView.count(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: aspectRatio,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final product in MockCatalog.products)
                  ProductCard(
                    productId: product.id,
                    category: product.category,
                    name: product.name,
                    price: product.formattedPrice,
                    badge: product.badge,
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
