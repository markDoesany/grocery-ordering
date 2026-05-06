import 'package:flutter/material.dart';

/// Reusable section header: title + optional trailing widget + bottom border.
///
/// [large] — uses headlineMedium (24px) instead of headlineSmall (20px).
/// [usePrimaryBorder] — uses colorScheme.primary instead of colorScheme.outline.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.large = false,
    this.usePrimaryBorder = false,
  });

  final String title;
  final Widget? trailing;
  final bool large;
  final bool usePrimaryBorder;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final borderColor = usePrimaryBorder ? cs.primary : cs.outlineVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                title,
                style: (large ? tt.headlineMedium : tt.headlineSmall)?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.1,
                ),
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 36,
              height: 3,
              decoration: BoxDecoration(
                color: usePrimaryBorder ? cs.primary : cs.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Divider(
                height: 3,
                thickness: 1,
                color: borderColor.withValues(alpha: 0.72),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
