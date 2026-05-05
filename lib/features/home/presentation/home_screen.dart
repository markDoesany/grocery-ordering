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
import 'widgets/hero_banner_section.dart';
import 'widgets/home_top_app_bar.dart';
import 'widgets/product_grid_section.dart';
import 'widgets/promotions_section.dart';
import 'widgets/quick_reorder_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandingAsync = ref.watch(brandingProvider);
    return brandingAsync.when(
      loading: () => const Scaffold(body: LoadingIndicator()),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (branding) => MobileScaffold(
        currentTab: AppTab.restock,
        cartSummary: ref.watch(cartSummaryProvider),
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: HomeTopAppBar(
          title: branding.displayName,
          onSearchTap: () => context.go(AppConstants.searchRoute),
          onFilterTap: () => showMockActionSheet(
            context,
            title: 'Catalog filters',
            options: const ['Low stock', 'Promotions', 'Recently ordered'],
          ),
        ),
        body: const _CatalogBody(),
      ),
    );
  }
}

/// Main catalog/restock content - scrollable column of sections.
class _CatalogBody extends StatelessWidget {
  const _CatalogBody();

  @override
  Widget build(BuildContext context) {
    return const AppScrollView(
      children: [
        PromotionsSection(),
        SizedBox(height: 24),
        HeroBannerSection(),
        SizedBox(height: 24),
        QuickReorderSection(),
        SizedBox(height: 24),
        ProductGridSection(),
        SizedBox(height: 24),
      ],
    );
  }
}
