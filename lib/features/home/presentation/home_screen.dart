import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/branding/domain/branding_provider.dart';
import '../../../features/cart/domain/cart_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../shared/utils/mock_actions.dart';
import '../../../shared/widgets/app_scroll_view.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../../shared/widgets/mobile_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'widgets/catalog_cart_strip.dart';
import 'widgets/home_top_app_bar.dart';
import 'widgets/low_stock_section.dart';
import 'widgets/product_grid_section.dart';
import 'widgets/promotions_section.dart';
import 'widgets/quick_reorder_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandingAsync = ref.watch(brandingProvider);
    final cartSummary = ref.watch(cartSummaryProvider);

    return brandingAsync.when(
      loading: () => const Scaffold(body: LoadingIndicator()),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (branding) => MobileScaffold(
        currentTab: AppTab.restock,
        cartSummary: cartSummary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: HomeTopAppBar(
          title: branding.displayName,
          onSearchTap: () => context.go(AppConstants.searchRoute),
          onFilterTap: () => showMockActionSheet(
            context,
            title: 'I-filter ang catalog',
            options: const [
              'Mababa ang stock',
              'Mga promo',
              'Kamakailan na na-order',
            ],
          ),
        ),
        body: const _CatalogBody(),
        // Sticky running total — only shown when there are items in cart.
        bottom: cartSummary.itemCount > 0
            ? CatalogCartStrip(summary: cartSummary)
            : null,
      ),
    );
  }
}

/// Restock-first layout:
///   1. Quick Reorder — repeat familiar items with one tap
///   2. Low Stock alerts — operational priority
///   3. All Products grid — browse and add new items
///   4. Promotions — secondary discovery, seen after task-focused sections
class _CatalogBody extends StatelessWidget {
  const _CatalogBody();

  @override
  Widget build(BuildContext context) {
    return const AppScrollView(
      children: [
        QuickReorderSection(),
        SizedBox(height: 24),
        LowStockSection(),
        SizedBox(height: 24),
        ProductGridSection(),
        SizedBox(height: 24),
        PromotionsSection(),
        SizedBox(height: 24),
      ],
    );
  }
}
