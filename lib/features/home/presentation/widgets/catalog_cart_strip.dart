import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../features/cart/domain/cart_provider.dart';

/// Sticky bottom strip shown on catalog/search screens when the cart has items.
/// Displays running item count + subtotal and links directly to the cart.
class CatalogCartStrip extends StatelessWidget {
  const CatalogCartStrip({super.key, required this.summary});

  final CartSummary summary;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Material(
      color: cs.primary,
      child: InkWell(
        onTap: () => context.go(AppConstants.cartRoute),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Cart icon with item count
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cs.onPrimary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.shopping_basket_outlined, color: cs.onPrimary, size: 20),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: cs.onPrimary,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            summary.itemCount > 99 ? '99+' : '${summary.itemCount}',
                            style: tt.labelSmall?.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Item count label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${summary.itemCount} ${summary.itemCount == 1 ? 'item' : 'items'}',
                        style: tt.labelMedium?.copyWith(
                          color: cs.onPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                      Text(
                        summary.formattedSubtotal,
                        style: tt.titleMedium?.copyWith(
                          color: cs.onPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                // CTA
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'I-review ang order',
                      style: tt.labelLarge?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward, color: cs.onPrimary, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
