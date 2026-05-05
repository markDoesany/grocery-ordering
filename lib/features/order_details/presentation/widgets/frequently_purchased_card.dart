import 'package:flutter/material.dart';
import '../../../../../shared/widgets/app_surface.dart';
import '../../../../../shared/widgets/image_placeholder.dart';

/// 160px-wide card for the Frequently Purchased horizontal carousel.
class FrequentlyPurchasedCard extends StatelessWidget {
  const FrequentlyPurchasedCard({
    super.key,
    required this.name,
    required this.price,
    this.onAdd,
  });

  final String name;
  final String price;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SizedBox(
      width: 160,
      child: AppSurface(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: ImagePlaceholder(height: 96, iconSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: tt.bodySmall?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Material(
                    color: cs.primaryContainer.withValues(alpha: 0.34),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: onAdd,
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 36,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 14, color: cs.primary),
                            const SizedBox(width: 4),
                            Text(
                              'ADD',
                              style: tt.labelLarge?.copyWith(color: cs.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
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
