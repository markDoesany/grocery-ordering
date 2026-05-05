import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/cart/domain/cart_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../shared/widgets/app_action_button.dart';
import '../../../shared/utils/mock_actions.dart';
import 'widgets/delivery_details_section.dart';
import 'widgets/order_summary_section.dart';
import 'widgets/payment_method_section.dart';

/// Transactional checkout flow - no bottom nav, close button returns to catalog.
class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final summary = ref.watch(cartSummaryProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: _CheckoutAppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const OrderSummarySection(),
            const SizedBox(height: 16),
            const DeliveryDetailsSection(),
            const SizedBox(height: 16),
            const PaymentMethodSection(),
            const SizedBox(height: 24),
            AppActionButton(
              label: 'Place Order  •  ${summary.formattedTotal}',
              onTap: summary.itemCount > 0
                  ? () {
                      ref.read(cartProvider.notifier).clear();
                      context.go(AppConstants.orderSummaryRoute);
                    }
                  : () => showMockSnack(
                      context,
                      'Add items before placing order',
                    ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
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
                onTap: () => popOrGo(context, AppConstants.cartRoute),
                child: Icon(Icons.close, color: cs.primary),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'CHECKOUT',
              style: tt.headlineMedium?.copyWith(color: cs.primary),
            ),
          ],
        ),
      ),
    );
  }
}
