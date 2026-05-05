import 'package:flutter/material.dart';
import '../../../../../shared/widgets/app_action_button.dart';
import '../../../checkout/presentation/widgets/price_row.dart';

/// Sticky-bottom ledger — subtotal, tax, total, and Proceed to Checkout button.
class LedgerTotalSection extends StatelessWidget {
  const LedgerTotalSection({
    super.key,
    required this.subtotal,
    required this.tax,
    required this.total,
    this.onCheckout,
  });

  final String subtotal;
  final String tax;
  final String total;
  final VoidCallback? onCheckout;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.primary, width: 2)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PriceRow(label: 'Subtotal', value: subtotal),
          const SizedBox(height: 4),
          PriceRow(label: 'Tax', value: tax),
          const SizedBox(height: 4),
          Divider(thickness: 1, color: cs.outline),
          const SizedBox(height: 4),
          PriceRow(label: 'Total', value: total, isTotal: true),
          const SizedBox(height: 16),
          Opacity(
            opacity: onCheckout == null ? 0.45 : 1,
            child: AppActionButton(
              label: 'Proceed to Checkout',
              onTap: onCheckout,
            ),
          ),
        ],
      ),
    );
  }
}
