import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/cart/domain/cart_provider.dart';
import '../../../../shared/widgets/badge_label.dart';
import '../../../../shared/widgets/app_surface.dart';
import '../../../../shared/widgets/image_placeholder.dart';
import 'quantity_stepper.dart';

/// Small product card used in the Quick Reorder horizontal scroll.
/// Shows a stepper when the item is already in cart, an "Add" button otherwise.
class QuickReorderItemCard extends ConsumerWidget {
  const QuickReorderItemCard({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    this.badge,
  });

  final String productId;
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

    return SizedBox(
      width: 140,
      child: AppSurface(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                const ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: ImagePlaceholder(height: 88, iconSize: 28),
                ),
                // Info + action
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: tt.labelMedium?.copyWith(
                          color: cs.onSurface,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        price,
                        style: tt.labelLarge?.copyWith(
                          color: cs.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (quantity > 0)
                        QuantityStepper(
                          quantity: quantity,
                          onDecrement: () => cart.decrement(productId),
                          onIncrement: () => cart.increment(productId),
                          compact: true,
                        )
                      else
                        _AddButton(
                          onTap: () => cart.increment(productId),
                          cs: cs,
                          tt: tt,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (badge != null)
              Positioned(top: 0, right: 0, child: BadgeLabel(label: badge!)),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap, required this.cs, required this.tt});

  final VoidCallback onTap;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cs.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 36,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 16, color: cs.onPrimary),
              const SizedBox(width: 4),
              Text(
                'Idagdag',
                style: tt.labelMedium?.copyWith(color: cs.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
