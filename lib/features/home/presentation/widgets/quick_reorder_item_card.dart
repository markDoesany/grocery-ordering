import 'package:flutter/material.dart';
import '../../../../shared/widgets/badge_label.dart';
import '../../../../shared/widgets/app_surface.dart';
import '../../../../shared/widgets/image_placeholder.dart';

/// Small 128-wide product card used in the Quick Reorder horizontal scroll.
/// Optional [badge] shows a corner label (e.g. "NEW").
class QuickReorderItemCard extends StatelessWidget {
  const QuickReorderItemCard({
    super.key,
    required this.name,
    required this.price,
    this.badge,
    this.onActionTap,
  });

  final String name;
  final String price;
  final String? badge;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SizedBox(
      width: 128,
      child: AppSurface(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  child: const ImagePlaceholder(height: 96, iconSize: 32),
                ),
                // Info + button
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: tt.labelLarge?.copyWith(color: cs.onSurface),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        price,
                        style: tt.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Material(
                        color: cs.primary,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: onActionTap,
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'ADD',
                                style: tt.labelLarge?.copyWith(
                                  color: cs.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
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
      ),
    );
  }
}
