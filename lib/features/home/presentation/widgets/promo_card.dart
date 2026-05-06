import 'package:flutter/material.dart';
import '../../../../shared/widgets/badge_label.dart';
import '../../../../shared/widgets/app_action_button.dart';
import '../../../../shared/widgets/app_surface.dart';

/// Compact promotional card — badge, headline, brief subtext, and action button.
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
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BadgeLabel(label: badge),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            headline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: tt.titleMedium?.copyWith(
              color: cs.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtext,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: tt.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
              height: 1.3,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: AppActionButton(
              label: actionLabel,
              filled: filled,
              onTap: onActionTap,
              height: 36,
            ),
          ),
        ],
      ),
    );
  }
}
