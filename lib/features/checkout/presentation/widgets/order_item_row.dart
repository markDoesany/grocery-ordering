import 'package:flutter/material.dart';

/// One line item in the order summary list — name + qty on left, price on right.
class OrderItemRow extends StatelessWidget {
  const OrderItemRow({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String name;
  final String quantity;
  final String price;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: tt.bodyMedium?.copyWith(color: cs.onSurface)),
              const SizedBox(height: 2),
              Text(
                'Qty: $quantity',
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: tt.bodyMedium?.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
