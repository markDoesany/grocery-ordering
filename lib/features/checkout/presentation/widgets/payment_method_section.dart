import 'package:flutter/material.dart';
import '../../../../shared/utils/mock_actions.dart';
import '../../../../shared/widgets/app_surface.dart';

/// "Payment Method" card — card icon + masked card number with a Change link.
class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return AppSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'PAYMENT METHOD',
                style: tt.headlineSmall?.copyWith(color: cs.primary),
              ),
              GestureDetector(
                onTap: () => showMockActionSheet(
                  context,
                  title: 'Payment method',
                  options: const [
                    'Visa ending in 4242',
                    'Cash on delivery',
                    'Add new card',
                  ],
                ),
                child: Text(
                  'CHANGE',
                  style: tt.labelSmall?.copyWith(
                    color: cs.secondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Divider(
            height: 1,
            thickness: 1,
            color: cs.outlineVariant.withValues(alpha: 0.70),
          ),
          const SizedBox(height: 16),

          // Payment row
          Row(
            children: [
              Icon(Icons.credit_card_outlined, color: cs.outline),
              const SizedBox(width: 12),
              Text(
                'Visa ending in •••• 4242',
                style: tt.bodyMedium?.copyWith(color: cs.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
