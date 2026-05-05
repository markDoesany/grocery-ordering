import 'package:flutter/material.dart';
import '../../../../../shared/widgets/image_placeholder.dart';

/// Stock level variant for an inventory card.
enum StockStatus { critical, low, normal }

/// Full-width inventory card — aspect-video image, stock badge, ON HAND stepper,
/// action button (URGENT RESTOCK filled / ADD TO RESTOCK LIST outlined).
class InventoryCard extends StatelessWidget {
  const InventoryCard({
    super.key,
    required this.name,
    required this.department,
    required this.sku,
    required this.price,
    required this.onHand,
    required this.stockStatus,
    required this.onDecrement,
    required this.onIncrement,
    this.onAction,
  });

  final String name;
  final String department;
  final String sku;
  final String price;
  final int onHand;
  final StockStatus stockStatus;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final badgeLabel = switch (stockStatus) {
      StockStatus.critical => 'CRITICAL STOCK',
      StockStatus.low => 'LOW STOCK',
      StockStatus.normal => 'IN STOCK',
    };

    final badgeBg = switch (stockStatus) {
      StockStatus.critical => cs.secondary,
      StockStatus.low => cs.primary,
      StockStatus.normal => cs.surfaceTint,
    };

    final isUrgent = stockStatus == StockStatus.critical;

    return Container(
      decoration: BoxDecoration(border: Border.all(color: cs.outlineVariant)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Aspect-video image with stock badge overlay
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: ImagePlaceholder(
                    height: double.infinity,
                    iconSize: 40,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    color: badgeBg,
                    child: Text(
                      badgeLabel,
                      style: tt.labelSmall?.copyWith(color: cs.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + department + sku row
                Text(
                  name,
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$department  •  $sku',
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: tt.bodyMedium?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                // ON HAND stepper
                Row(
                  children: [
                    Text(
                      'ON HAND',
                      style: tt.labelLarge?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _InventoryStepper(
                      value: onHand,
                      onDecrement: onDecrement,
                      onIncrement: onIncrement,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Action button
                GestureDetector(
                  onTap: onAction,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: isUrgent ? cs.primary : null,
                      border: Border.all(color: cs.primary, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isUrgent ? 'URGENT RESTOCK' : 'ADD TO RESTOCK LIST',
                      style: tt.labelLarge?.copyWith(
                        color: isUrgent ? cs.onPrimary : cs.primary,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact stepper for inventory on-hand count — 36px height, 48px count area.
class _InventoryStepper extends StatelessWidget {
  const _InventoryStepper({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: 36,
      decoration: BoxDecoration(border: Border.all(color: cs.primary)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepBtn(label: '−', onTap: onDecrement, borderRight: true),
          SizedBox(
            width: 48,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: tt.labelLarge?.copyWith(color: cs.onSurface),
            ),
          ),
          _StepBtn(label: '+', onTap: onIncrement, borderLeft: true),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({
    required this.label,
    required this.onTap,
    this.borderRight = false,
    this.borderLeft = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool borderRight;
  final bool borderLeft;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: cs.surfaceContainerLowest,
          border: Border(
            right: borderRight
                ? BorderSide(color: cs.primary)
                : BorderSide.none,
            left: borderLeft ? BorderSide(color: cs.primary) : BorderSide.none,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
      ),
    );
  }
}
