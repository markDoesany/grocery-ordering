import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/cart/domain/cart_provider.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../features/home/presentation/widgets/catalog_cart_strip.dart';
import '../../../features/home/presentation/widgets/home_top_app_bar.dart';
import '../../../shared/data/mock_catalog.dart';
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

  static const _categories = [
    'Lahat',
    'Beverages',
    'Canned Goods',
    'Bigas at Pampalasa',
    'Meryenda',
    'Panlinis',
  ];

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
            ),
            const SizedBox(height: 16),
            CategoryChipRow(
              categories: _categories,
              selectedIndex: _selectedCategory,
              onSelected: (i) => setState(() => _selectedCategory = i),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                for (final product in MockCatalog.products) ...[
                  SearchProductCard(
                    productId: product.id,
                    category: product.category,
                    name: product.name,
                    price: product.formattedPrice,
                    badge: product.badge,
                  ),
                  if (product != MockCatalog.products.last)
                    const SizedBox(height: 12),
                ],
              ],
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
