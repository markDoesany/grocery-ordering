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
  });

  final String productId;
  final String category;
  final String name;
  final String price;
  final String? badge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final quantity = ref.watch(
      cartProvider.select((cart) => cart[productId] ?? 0),
    );
    final cart = ref.read(cartProvider.notifier);

    return AppSurface(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                child: const ImagePlaceholder(height: 128, iconSize: 40),
              ),
              // Card body
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.toUpperCase(),
                      style: tt.labelLarge?.copyWith(
                        color: cs.onSurfaceVariant,
                        letterSpacing: 1.5,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: cs.outlineVariant.withValues(alpha: 0.68),
                    ),
                    const SizedBox(height: 8),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final stepper = QuantityStepper(
                          quantity: quantity,
                          onDecrement: () => cart.decrement(productId),
                          onIncrement: () => cart.increment(productId),
                        );
                        final price = Text(
                          this.price,
                          style: tt.bodyLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        );

                        if (constraints.maxWidth < 140) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              price,
                              const SizedBox(height: 8),
                              stepper,
                            ],
                          );
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [price, stepper],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Corner badge
          if (badge != null)
            Positioned(top: 0, right: 0, child: BadgeLabel(label: badge!)),
        ],
      ),
    );
  }
}
