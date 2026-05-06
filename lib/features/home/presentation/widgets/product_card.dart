import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/cart/domain/cart_provider.dart';
import '../../../../shared/widgets/badge_label.dart';
import '../../../../shared/widgets/app_surface.dart';
import '../../../../shared/widgets/image_placeholder.dart';
import 'quantity_stepper.dart';

/// Grid product card — category label, name, price, quantity stepper.
/// Optional [badge] shows a corner label.
class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.productId,
    required this.category,
    required this.name,
    required this.price,
    this.badge,
    this.packSize,
    this.isLowStock = false,
  });

  final String productId;
  final String category;
  final String name;
  final String price;
  final String? badge;
  final String? packSize;
  final bool isLowStock;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final quantity = ref.watch(
      cartProvider.select((cart) => cart[productId] ?? 0),
    );
    final cart = ref.read(cartProvider.notifier);

    final badgeColor = isLowStock ? cs.error : null;

    return AppSurface(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              const ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                child: ImagePlaceholder(height: 112, iconSize: 36),
              ),
              // Card body
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    if (packSize != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        packSize!,
                        style: tt.labelSmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: cs.outlineVariant.withValues(alpha: 0.68),
                    ),
                    const SizedBox(height: 8),
                    // Price — prominent
                    Text(
                      price,
                      style: tt.titleMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Stepper — full width
                    QuantityStepper(
                      quantity: quantity,
                      onDecrement: () => cart.decrement(productId),
                      onIncrement: () => cart.increment(productId),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Corner badge
          if (badge != null)
            Positioned(
              top: 0,
              right: 0,
              child: BadgeLabel(label: badge!, color: badgeColor),
            ),
        ],
      ),
    );
  }
}
