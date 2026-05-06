import 'package:flutter/material.dart';

/// Small badge chip — surface-tint background, on-primary text, label style.
/// Used on promo cards, hero banners, and product cards.
class BadgeLabel extends StatelessWidget {
  const BadgeLabel({super.key, required this.label, this.color});

  final String label;

  /// Override background color — defaults to primaryContainer.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final bg = (color ?? cs.primaryContainer).withValues(alpha: 0.92);
    final fg = color != null ? cs.onError : cs.onPrimaryContainer;
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        label,
        style: tt.labelSmall?.copyWith(
          color: fg,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
