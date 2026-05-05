import 'package:flutter/material.dart';
import '../../../../shared/utils/mock_actions.dart';
import '../../../../shared/widgets/app_surface.dart';

/// "Delivery Details" card — address + instructions with an Edit link.
class DeliveryDetailsSection extends StatelessWidget {
  const DeliveryDetailsSection({super.key});

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
                'DELIVERY DETAILS',
                style: tt.headlineSmall?.copyWith(color: cs.primary),
              ),
              GestureDetector(
                onTap: () => showMockActionSheet(
                  context,
                  title: 'Delivery details',
                  options: const [
                    'Use saved store address',
                    'Edit instructions',
                    'Schedule delivery window',
                  ],
                ),
                child: Text(
                  'EDIT',
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

          // Address row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on_outlined, color: cs.outline),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '123 Mercantile Ave, Apt 4B',
                      style: tt.bodyMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Brooklyn, NY 11201',
                      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Instructions: Leave at front desk.',
                      style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
