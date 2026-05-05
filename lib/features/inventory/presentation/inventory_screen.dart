import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/cart/domain/cart_provider.dart';
import '../../../shared/utils/mock_actions.dart';
import '../../../shared/widgets/mobile_scaffold.dart';
import 'widgets/inventory_controls_header.dart';
import 'widgets/inventory_card.dart';

/// Inventory Control screen — menu | title | filter AppBar, Restock tab active.
class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  // Stub on-hand quantities — replaced when data layer is wired.
  final List<int> _onHand = [2, 8, 24];

  void _decrement(int i) {
    if (_onHand[i] > 0) setState(() => _onHand[i]--);
  }

  void _increment(int i) => setState(() => _onHand[i]++);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return MobileScaffold(
      currentIndex: 0,
      cartSummary: ref.watch(cartSummaryProvider),
      backgroundColor: cs.surface,
      appBar: _InventoryAppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InventoryControlsHeader(
              onSortFilter: () => showMockActionSheet(
                context,
                title: 'Inventory filters',
                options: const ['Critical stock', 'Low stock', 'Department'],
              ),
              onGenerateOrder: () =>
                  showMockSnack(context, 'Draft restock order generated'),
            ),
            const SizedBox(height: 16),
            InventoryCard(
              name: 'Product Name',
              department: 'Department',
              sku: 'SKU-001',
              price: '₱0.00',
              onHand: _onHand[0],
              stockStatus: StockStatus.critical,
              onDecrement: () => _decrement(0),
              onIncrement: () => _increment(0),
              onAction: () =>
                  showMockSnack(context, 'Added SKU-001 to restock list'),
            ),
            const SizedBox(height: 12),
            InventoryCard(
              name: 'Product Name',
              department: 'Department',
              sku: 'SKU-002',
              price: '₱0.00',
              onHand: _onHand[1],
              stockStatus: StockStatus.low,
              onDecrement: () => _decrement(1),
              onIncrement: () => _increment(1),
              onAction: () =>
                  showMockSnack(context, 'Added SKU-002 to restock list'),
            ),
            const SizedBox(height: 12),
            InventoryCard(
              name: 'Product Name',
              department: 'Department',
              sku: 'SKU-003',
              price: '₱0.00',
              onHand: _onHand[2],
              stockStatus: StockStatus.normal,
              onDecrement: () => _decrement(2),
              onIncrement: () => _increment(2),
              onAction: () =>
                  showMockSnack(context, 'Added SKU-003 to restock list'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _InventoryAppBar extends StatelessWidget implements PreferredSizeWidget {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: InkWell(
                  onTap: () => showMockActionSheet(
                    context,
                    title: 'Inventory menu',
                    options: const [
                      'Restock queue',
                      'Supplier list',
                      'Reports',
                    ],
                  ),
                  child: Icon(Icons.menu, color: cs.onSurface),
                ),
              ),
              Expanded(
                child: Text(
                  'INVENTORY',
                  style: tt.headlineMedium?.copyWith(color: cs.primary),
                ),
              ),
              SizedBox(
                width: 44,
                height: 44,
                child: InkWell(
                  onTap: () => showMockActionSheet(
                    context,
                    title: 'Inventory filters',
                    options: const [
                      'Critical stock',
                      'Low stock',
                      'Department',
                    ],
                  ),
                  child: Icon(Icons.filter_list, color: cs.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
