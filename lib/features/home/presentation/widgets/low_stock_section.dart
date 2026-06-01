import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/cart/domain/cart_provider.dart';
import '../../../../shared/models/product_model.dart';
import '../../../../shared/providers/catalog_provider.dart';
import '../../../../shared/widgets/app_surface.dart';
import '../../../../shared/widgets/image_placeholder.dart';
import '../../../../shared/widgets/section_header.dart';
import 'quantity_stepper.dart';

/// Operational alert row: products that are low or out of stock.
/// Gives the store owner a fast way to restock before they run out.
class LowStockSection extends ConsumerWidget {
  const LowStockSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final productsAsync = ref.watch(catalogProvider);

    return productsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
      data: (allProducts) {
        final products = allProducts
            .where((p) => p.isLowStock || p.isOutOfStock)
            .toList(growable: false);

        if (products.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Kailangan ng restock',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: cs.errorContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${products.length} item',
                  style: tt.labelSmall?.copyWith(
                    color: cs.onErrorContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final product in products) ...[
                    _LowStockCard(product: product),
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

class _LowStockCard extends ConsumerWidget {
  const _LowStockCard({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final quantity = ref.watch(
      cartProvider.select((cart) => cart[product.id] ?? 0),
    );
    final cart = ref.read(cartProvider.notifier);

    final isOut = product.isOutOfStock;
    final statusColor = isOut ? cs.error : cs.tertiary;
    final statusLabel = isOut ? 'Wala na' : 'Mababa na';

    return SizedBox(
      width: 160,
      child: AppSurface(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with colored status strip
            Stack(
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: ImagePlaceholder(height: 80, iconSize: 24),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        statusLabel,
                        style: tt.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: tt.labelMedium?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.formattedPrice,
                    style: tt.labelLarge?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (isOut)
                    Container(
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: cs.error),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Wala sa stock',
                        style: tt.labelSmall?.copyWith(color: cs.error),
                      ),
                    )
                  else
                    QuantityStepper(
                      quantity: quantity,
                      onDecrement: () => cart.decrement(product.id),
                      onIncrement: () => cart.increment(product.id),
                      compact: true,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
