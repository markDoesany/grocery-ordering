import 'package:flutter/material.dart';

/// Price breakdown + Reorder button at the bottom of Order Details.
class OrderDetailsSummarySection extends StatelessWidget {
  const OrderDetailsSummarySection({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.tax,
    required this.totalPaid,
    this.onReorder,
  });

  final String subtotal;
  final String deliveryFee;
  final String discount;
  final String tax;
  final String totalPaid;
  final VoidCallback? onReorder;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: cs.outlineVariant)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SummaryLine(
            label: 'Subtotal',
            value: subtotal,
            valueColor: cs.onSurface,
          ),
          const SizedBox(height: 4),
          _SummaryLine(
            label: 'Delivery Fee',
            value: deliveryFee,
            valueColor: cs.onSurface,
          ),
          const SizedBox(height: 4),
          _SummaryLine(
            label: 'Discount',
            value: '−$discount',
            valueColor: cs.secondary,
          ),
          const SizedBox(height: 4),
          _SummaryLine(label: 'Tax', value: tax, valueColor: cs.onSurface),
          const SizedBox(height: 8),
          Divider(thickness: 2, color: cs.primary),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  'TOTAL PAID',
                  style: tt.headlineSmall?.copyWith(color: cs.onSurface),
                ),
              ),
              Text(
                totalPaid,
                style: tt.headlineSmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onReorder,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: cs.primary, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                'REORDER',
                style: tt.labelLarge?.copyWith(
                  color: cs.primary,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
        ),
        Text(
          value,
          style: tt.bodyMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
