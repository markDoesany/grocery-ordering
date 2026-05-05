import 'package:flutter/material.dart';
import '../../../../../shared/widgets/app_surface.dart';
import '../../../../../shared/widgets/badge_label.dart';

/// Two-column grid of order metadata.
class ReceiptInfoSection extends StatelessWidget {
  const ReceiptInfoSection({
    super.key,
    required this.orderNumber,
    required this.orderDate,
    required this.status,
    required this.itemCount,
  });

  final String orderNumber;
  final String orderDate;
  final String status;
  final String itemCount;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return AppSurface(
      padding: const EdgeInsets.all(12),
      highlight: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _InfoCell(label: 'ORDER NUMBER', value: orderNumber),
              ),
              Expanded(
                child: _InfoCell(label: 'ORDER DATE', value: orderDate),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STATUS',
                      style: tt.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    BadgeLabel(label: status),
                  ],
                ),
              ),
              Expanded(child: _InfoCell(label: 'ITEMS', value: itemCount)),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(
          value,
          style: tt.bodyMedium?.copyWith(
            color: cs.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
