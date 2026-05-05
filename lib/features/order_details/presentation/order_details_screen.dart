import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../features/cart/domain/cart_provider.dart';
import '../../../shared/utils/mock_actions.dart';
import '../../../shared/widgets/mobile_scaffold.dart';
import '../../../shared/widgets/section_header.dart';
import 'widgets/frequently_purchased_section.dart';
import 'widgets/ledger_item_row.dart';
import 'widgets/order_details_summary_section.dart';
import 'widgets/receipt_info_section.dart';

/// Order receipt view - back-button AppBar, History tab (index 2) active.
class OrderDetailsScreen extends ConsumerWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return MobileScaffold(
      currentTab: AppTab.history,
      cartSummary: ref.watch(cartSummaryProvider),
      backgroundColor: cs.surface,
      appBar: _OrderDetailsAppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReceiptInfoSection(
              orderNumber: '#000001',
              orderDate: 'Jan 1, 2025',
              status: 'Delivered',
              itemCount: '3 items',
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: cs.primary, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Items Ordered',
                    usePrimaryBorder: true,
                  ),
                  const LedgerItemRow(
                    name: 'Canned Sardines',
                    category: 'Pantry',
                    quantity: 2,
                    unitPrice: '₱27.50',
                    lineTotal: '₱55.00',
                  ),
                  Divider(thickness: 1, color: cs.outlineVariant),
                  const LedgerItemRow(
                    name: 'Instant Coffee',
                    category: 'Beverages',
                    quantity: 1,
                    unitPrice: '₱8.75',
                    lineTotal: '₱8.75',
                  ),
                  Divider(thickness: 1, color: cs.outlineVariant),
                  const LedgerItemRow(
                    name: 'Laundry Sachet',
                    category: 'Household',
                    quantity: 3,
                    unitPrice: '₱12.00',
                    lineTotal: '₱36.00',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            OrderDetailsSummarySection(
              subtotal: '₱99.75',
              deliveryFee: '₱0.00',
              discount: '₱0.00',
              tax: '₱7.98',
              totalPaid: '₱107.73',
              onReorder: () {
                ref.read(cartProvider.notifier)
                  ..clear()
                  ..increment('sku-001')
                  ..increment('sku-002')
                  ..increment('sku-003');
                context.go(AppConstants.cartRoute);
              },
            ),
            const SizedBox(height: 16),
            FrequentlyPurchasedSection(
              onSeeAll: () => showMockActionSheet(
                context,
                title: 'Frequently purchased',
                options: const ['Pantry staples', 'Beverages', 'Household'],
              ),
              onAdd: (productId) {
                ref.read(cartProvider.notifier).increment(productId);
                showMockSnack(context, 'Added item to cart');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _OrderDetailsAppBar extends StatelessWidget
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
                onTap: () => popOrGo(context, AppConstants.homeRoute),
                child: Icon(Icons.arrow_back, color: cs.primary),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'ORDER DETAILS',
              style: tt.headlineMedium?.copyWith(color: cs.primary),
            ),
          ],
        ),
      ),
    );
  }
}
