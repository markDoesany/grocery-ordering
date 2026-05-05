import 'package:flutter/material.dart';
import '../../../../shared/widgets/badge_label.dart';
import '../../../../shared/widgets/app_action_button.dart';
import '../../../../shared/widgets/app_surface.dart';

/// Promotional card — border-2 primary, badge + headline + subtext + action button.
///
/// [filled] — true: button is bg=primary (filled); false: button is outlined.
class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    required this.badge,
    required this.headline,
    required this.subtext,
    required this.actionLabel,
    this.filled = true,
    this.onActionTap,
  });

  final String badge;
  final String headline;
  final String subtext;
  final String actionLabel;
  final bool filled;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return AppSurface(
      highlight: true,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BadgeLabel(label: badge),
          const SizedBox(height: 8),
          Text(
            headline,
            style: tt.headlineSmall?.copyWith(
              color: cs.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: tt.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: AppActionButton(
              label: actionLabel,
              filled: filled,
              onTap: onActionTap,
              height: 44,
            ),
          ),
        ],
      ),
    );
  }
}
