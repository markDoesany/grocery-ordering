import 'package:flutter/material.dart';
import '../../../../../shared/utils/mock_actions.dart';
import '../../../../../shared/widgets/app_action_button.dart';
import '../../../../../shared/widgets/app_surface.dart';

/// Single available-reward card — title, cost, redeem or insufficient button.
class RewardCard extends StatelessWidget {
  const RewardCard({
    super.key,
    required this.title,
    required this.cost,
    required this.canRedeem,
    this.onRedeem,
  });

  final String title;
  final String cost;
  final bool canRedeem;
  final VoidCallback? onRedeem;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return AppSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: tt.bodyLarge?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'COST: $cost',
                style: tt.labelSmall?.copyWith(color: cs.secondaryContainer),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppActionButton(
            label: canRedeem ? 'Redeem' : 'Insufficient Points',
            filled: canRedeem,
            height: 44,
            onTap: canRedeem
                ? onRedeem
                : () => showMockSnack(context, 'Not enough points yet'),
          ),
        ],
      ),
    );
  }
}
