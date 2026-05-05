import 'package:flutter/material.dart';

/// Gray box with a centered image icon — stands in for product/promo images.
class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
    required this.height,
    this.width = double.infinity,
    this.iconSize = 40,
  });

  final double height;
  final double width;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primaryContainer.withValues(alpha: 0.30),
            cs.surfaceContainerHighest,
            cs.secondaryContainer.withValues(alpha: 0.24),
          ],
        ),
      ),
      child: Icon(
        Icons.inventory_2_outlined,
        size: iconSize,
        color: cs.primary.withValues(alpha: 0.46),
      ),
    );
  }
}
