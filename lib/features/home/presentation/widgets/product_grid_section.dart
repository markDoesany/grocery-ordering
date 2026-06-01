import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/catalog_provider.dart';
import '../../../../shared/utils/mock_actions.dart';
import '../../../../shared/widgets/section_header.dart';
import 'product_card.dart';

/// Responsive product grid with a section header and filter button.
class ProductGridSection extends ConsumerWidget {
  const ProductGridSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final productsAsync = ref.watch(catalogProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Lahat ng produkto',
          large: true,
          usePrimaryBorder: true,
          trailing: Material(
            color: cs.surfaceContainerLowest,
            child: InkWell(
              onTap: () => showMockActionSheet(
                context,
                title: 'I-filter ang produkto',
                options: const [
                  'Pinaka-mabenta',
                  'Mababa ang stock',
                  'Sale items',
                  'Ayon sa kategorya',
                ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: cs.outline),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.tune, size: 16, color: cs.onSurface),
                    const SizedBox(width: 4),
                    Text(
                      'I-filter',
                      style: tt.labelMedium?.copyWith(color: cs.onSurface),
                    ),
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
              < 340 => 0.50,
              < 560 => 0.58,
              _ => 0.64,
            };
            return productsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(12),
                child: Text('Unable to load products: $e'),
              ),
              data: (products) => GridView.count(
                crossAxisCount: columns,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: aspectRatio,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (final product in products)
                    ProductCard(
                      productId: product.id,
                      category: product.category,
                      name: product.name,
                      price: product.formattedPrice,
                      badge: product.badge,
                      packSize: product.packSize,
                      isLowStock: product.isLowStock,
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
