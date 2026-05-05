import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_action_button.dart';

/// Sticky bottom bar showing order total and Confirm Order button.
class StickyConfirmBar extends StatelessWidget {
  const StickyConfirmBar({super.key, required this.total, this.onConfirm});

  final String total;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.primary, width: 2)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ORDER TOTAL',
                style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              ),
              Text(
                total,
                style: tt.headlineSmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AppActionButton(label: 'Confirm Order', onTap: onConfirm),
          ),
        ],
      ),
    );
  }
}
