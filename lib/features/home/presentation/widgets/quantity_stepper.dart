import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [-] [count] [+] quantity stepper.
///
/// [compact] — 32px buttons, used inside tight cards (Quick Reorder).
/// Default — 40px buttons, used in the main product grid.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    this.compact = false,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final size = compact ? 32.0 : 40.0;
    final countWidth = compact ? 30.0 : 36.0;
    return Container(
      decoration: BoxDecoration(
        color: cs.primaryContainer.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.primary.withValues(alpha: 0.38)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(
            label: '−',
            size: size,
            borderSide: BorderSide(color: cs.primary),
            onTap: onDecrement,
          ),
          SizedBox(
            width: countWidth,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: tt.labelLarge?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _StepButton(
            label: '+',
            size: size,
            borderSide: BorderSide(color: cs.primary),
            onTap: onIncrement,
            leadingBorder: true,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.label,
    required this.size,
    required this.borderSide,
    required this.onTap,
    this.leadingBorder = false,
  });

  final String label;
  final double size;
  final BorderSide borderSide;
  final VoidCallback onTap;
  final bool leadingBorder;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surfaceContainerLowest,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border(
              right: BorderSide.none,
              left: leadingBorder ? borderSide : BorderSide.none,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
