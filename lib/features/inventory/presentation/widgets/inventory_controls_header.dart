import 'package:flutter/material.dart';
import '../../../../../shared/utils/mock_actions.dart';

/// Page title + Sort & Filter + Generate Order action buttons.
class InventoryControlsHeader extends StatelessWidget {
  const InventoryControlsHeader({
    super.key,
    this.onSortFilter,
    this.onGenerateOrder,
  });

  final VoidCallback? onSortFilter;
  final VoidCallback? onGenerateOrder;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INVENTORY CONTROL',
          style: tt.headlineMedium?.copyWith(color: cs.onSurface),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // Sort & Filter — outlined
            Expanded(
              child: GestureDetector(
                onTap:
                    onSortFilter ??
                    () => showMockSnack(context, 'Sort and filter opened'),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: cs.primary, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_list, size: 18, color: cs.primary),
                      const SizedBox(width: 6),
                      Text(
                        'SORT & FILTER',
                        style: tt.labelLarge?.copyWith(color: cs.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Generate Order — filled
            Expanded(
              child: GestureDetector(
                onTap:
                    onGenerateOrder ??
                    () => showMockSnack(context, 'Generated restock order'),
                child: Container(
                  height: 40,
                  color: cs.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_shopping_cart_outlined,
                        size: 18,
                        color: cs.onPrimary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'GENERATE ORDER',
                        style: tt.labelLarge?.copyWith(color: cs.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
