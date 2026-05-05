import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../features/checkout/presentation/widgets/price_row.dart';
import '../../../shared/utils/mock_actions.dart';
import '../../../shared/widgets/section_header.dart';
import 'widgets/sticky_confirm_bar.dart';
import 'widgets/summary_delivery_section.dart';
import 'widgets/summary_item_row.dart';
import 'widgets/summary_payment_section.dart';

/// Read-only order summary before confirming - back-button AppBar, sticky CTA.
class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      appBar: _OrderSummaryAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: cs.primary, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: 'Order Items',
                          usePrimaryBorder: true,
                        ),
                        const SummaryItemRow(
                          name: 'Canned Sardines',
                          quantity: 2,
                          unitPrice: '₱27.50',
                          lineTotal: '₱55.00',
                        ),
                        Divider(thickness: 1, color: cs.outlineVariant),
                        const SummaryItemRow(
                          name: 'Instant Coffee',
                          quantity: 1,
                          unitPrice: '₱8.75',
                          lineTotal: '₱8.75',
                        ),
                        Divider(thickness: 1, color: cs.outlineVariant),
                        const SummaryItemRow(
                          name: 'Laundry Sachet',
                          quantity: 3,
                          unitPrice: '₱12.00',
                          lineTotal: '₱36.00',
                        ),
                        const SizedBox(height: 8),
                        Divider(thickness: 2, color: cs.primary),
                        const SizedBox(height: 4),
                        const PriceRow(label: 'Subtotal', value: '₱99.75'),
                        const SizedBox(height: 4),
                        const PriceRow(label: 'Delivery Fee', value: '₱0.00'),
                        const SizedBox(height: 4),
                        const PriceRow(label: 'Tax', value: '₱7.98'),
                        const SizedBox(height: 4),
                        const PriceRow(
                          label: 'Total',
                          value: '₱107.73',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SummaryDeliverySection(),
                  const SizedBox(height: 16),
                  const SummaryPaymentSection(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          StickyConfirmBar(
            total: '₱107.73',
            onConfirm: () {
              showMockSnack(context, 'Order confirmed');
              context.go(AppConstants.homeRoute);
            },
          ),
        ],
      ),
    );
  }
}

class _OrderSummaryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(bottom: BorderSide(color: cs.primary, width: 2)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: InkWell(
                onTap: () => context.canPop()
                    ? context.pop()
                    : context.go(AppConstants.homeRoute),
                child: Icon(Icons.arrow_back, color: cs.primary),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'ORDER SUMMARY',
              style: tt.headlineMedium?.copyWith(color: cs.primary),
            ),
          ],
        ),
      ),
    );
  }
}
