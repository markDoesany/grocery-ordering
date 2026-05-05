import 'package:flutter/material.dart';
import '../../../home/presentation/widgets/quantity_stepper.dart';
import '../../../../../shared/widgets/app_surface.dart';
import '../../../../../shared/widgets/image_placeholder.dart';

/// Cart item row — 96×96 image, product info, QuantityStepper, remove button.
class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    required this.onRemove,
  });

  final String name;
  final String description;
  final String price;
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return AppSurface(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: const ImagePlaceholder(
                    width: 96,
                    height: 96,
                    iconSize: 32,
                  ),
                ),
                const SizedBox(width: 12),
                // Info + stepper
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: tt.bodyMedium?.copyWith(
                          color: cs.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          QuantityStepper(
                            quantity: quantity,
                            onDecrement: onDecrement,
                            onIncrement: onIncrement,
                          ),
                          const Spacer(),
                          Text(
                            price,
                            style: tt.bodyMedium?.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Spacer for remove button offset
                const SizedBox(width: 32),
              ],
            ),
          ),
          // Remove button — top-right
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: cs.errorContainer.withValues(alpha: 0.70),
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 18, color: cs.onErrorContainer),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
