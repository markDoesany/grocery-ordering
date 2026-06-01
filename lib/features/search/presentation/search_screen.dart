import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/cart/domain/cart_provider.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../features/home/presentation/widgets/catalog_cart_strip.dart';
import '../../../features/home/presentation/widgets/home_top_app_bar.dart';
import '../../../shared/providers/catalog_provider.dart';
import '../../../shared/utils/mock_actions.dart';
import '../../../shared/widgets/mobile_scaffold.dart';
import 'widgets/category_chip_row.dart';
import 'widgets/search_bar_input.dart';
import 'widgets/search_product_card.dart';

/// Product search screen - Search tab (index 1) active.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  int _selectedCategory = 0;
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cartSummary = ref.watch(cartSummaryProvider);
    final productsAsync = ref.watch(catalogProvider);

    return MobileScaffold(
      currentTab: AppTab.search,
      cartSummary: cartSummary,
      backgroundColor: cs.surface,
      appBar: HomeTopAppBar(
        title: 'Hanapin ang produkto',
        onSearchTap: () => _searchFocusNode.requestFocus(),
        onFilterTap: () => showMockActionSheet(
          context,
          title: 'I-filter ang resulta',
          options: const [
            'Kategorya',
            'Mababa ang stock',
            'Presyo: mababa patungo taas',
          ],
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarInput(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            productsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text('Unable to load products: $e'),
              ),
              data: (products) {
                final categories = [
                  'Lahat',
                  ...{
                    for (final product in products)
                      if (product.category.isNotEmpty) product.category,
                  },
                ];
                final selectedIndex = _selectedCategory.clamp(
                  0,
                  categories.length - 1,
                );
                final selectedCategory = categories[selectedIndex];
                final query = _searchController.text.trim().toLowerCase();

                final filtered = products
                    .where((product) {
                      final categoryMatch =
                          selectedCategory == 'Lahat' ||
                          product.category == selectedCategory;
                      final queryMatch =
                          query.isEmpty ||
                          product.name.toLowerCase().contains(query) ||
                          product.sku.toLowerCase().contains(query);
                      return categoryMatch && queryMatch;
                    })
                    .toList(growable: false);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryChipRow(
                      categories: categories,
                      selectedIndex: selectedIndex,
                      onSelected: (i) => setState(() => _selectedCategory = i),
                    ),
                    const SizedBox(height: 24),
                    if (filtered.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text('No products found.'),
                      ),
                    for (final product in filtered) ...[
                      SearchProductCard(
                        productId: product.id,
                        category: product.category,
                        name: product.name,
                        price: product.formattedPrice,
                        badge: product.badge,
                      ),
                      if (product != filtered.last) const SizedBox(height: 12),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottom: cartSummary.itemCount > 0
          ? CatalogCartStrip(summary: cartSummary)
          : null,
    );
  }
}
