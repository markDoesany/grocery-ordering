import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/domain/cart_provider.dart';
import '../../../../../shared/widgets/image_placeholder.dart';

/// Horizontal product card with cart-backed quantity state.
class SearchProductCard extends ConsumerWidget {
  const SearchProductCard({
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

    return SizedBox(
      height: 128,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainerLowest,
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 128,
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    border: Border(right: BorderSide(color: cs.outlineVariant)),
                  ),
                  child: const ImagePlaceholder(
                    height: double.infinity,
                    iconSize: 36,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.toUpperCase(),
                              style: tt.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              name,
                              style: tt.bodyMedium?.copyWith(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              price,
                              style: tt.bodyLarge?.copyWith(
                                color: cs.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            if (quantity == 0)
                              _AddButton(onTap: () => cart.increment(productId))
                            else
                              _InlineStepper(
                                quantity: quantity,
                                onDecrement: () => cart.decrement(productId),
                                onIncrement: () => cart.increment(productId),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                color: cs.surfaceDim,
                child: Text(
                  badge!,
                  style: tt.labelSmall?.copyWith(color: cs.onSurface),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surfaceContainerLowest,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: cs.primary, width: 2),
          ),
          child: Icon(Icons.add, size: 18, color: cs.primary),
        ),
      ),
    );
  }
}

class _InlineStepper extends StatelessWidget {
  const _InlineStepper({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: 36,
      decoration: BoxDecoration(border: Border.all(color: cs.outline)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Btn(
            icon: Icons.remove,
            onTap: onDecrement,
            borderRight: true,
            borderColor: cs.outline,
          ),
          SizedBox(
            width: 32,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: tt.labelLarge?.copyWith(color: cs.onSurface),
            ),
          ),
          _Btn(
            icon: Icons.add,
            onTap: onIncrement,
            borderLeft: true,
            borderColor: cs.outline,
          ),
        ],
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  const _Btn({
    required this.icon,
    required this.onTap,
    required this.borderColor,
    this.borderRight = false,
    this.borderLeft = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color borderColor;
  final bool borderRight;
  final bool borderLeft;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surfaceContainerLowest,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border(
              right: borderRight
                  ? BorderSide(color: borderColor)
                  : BorderSide.none,
              left: borderLeft
                  ? BorderSide(color: borderColor)
                  : BorderSide.none,
            ),
          ),
          child: Icon(icon, size: 14, color: cs.onSurface),
        ),
      ),
    );
  }
}
