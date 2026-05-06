import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppActionButton extends StatelessWidget {
  const AppActionButton({
    super.key,
    required this.label,
    this.onTap,
    this.filled = true,
    this.height = 56,
  });

  final String label;
  final VoidCallback? onTap;
  final bool filled;
  final double height;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final foreground = filled ? cs.onPrimary : cs.primary;
    final background = filled ? cs.primary : cs.surfaceContainerLowest;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap == null
            ? null
            : () {
                HapticFeedback.lightImpact();
                onTap!();
              },
        splashColor: cs.primary.withValues(alpha: 0.12),
        highlightColor: cs.primary.withValues(alpha: 0.08),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.primary, width: 2),
            boxShadow: filled
                ? [
                    BoxShadow(
                      color: cs.primary.withValues(alpha: 0.20),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: tt.labelLarge?.copyWith(
              color: foreground,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
