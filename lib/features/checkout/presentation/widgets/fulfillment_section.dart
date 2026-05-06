import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/fulfillment_provider.dart';
import '../map_picker_screen.dart';
import '../../../../shared/widgets/app_surface.dart';

/// Pickup / Delivery selector card used on the checkout screen.
///
/// Pickup → shows a simple "will collect from supplier" confirmation.
/// Delivery → shows the pinned map location (or a CTA to pin one).
class FulfillmentSection extends ConsumerWidget {
  const FulfillmentSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final state = ref.watch(fulfillmentProvider);
    final notifier = ref.read(fulfillmentProvider.notifier);

    return AppSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Paraan ng paghahatid',
            style: tt.headlineSmall?.copyWith(color: cs.primary),
          ),
          const SizedBox(height: 4),
          Divider(height: 1, thickness: 1, color: cs.outlineVariant.withValues(alpha: 0.70)),
          const SizedBox(height: 14),

          // Toggle
          _FulfillmentToggle(
            selected: state.type,
            onSelect: notifier.setType,
          ),

          const SizedBox(height: 16),

          // Content based on selection
          if (state.type == FulfillmentType.pickup)
            _PickupInfo()
          else
            _DeliveryInfo(
              state: state,
              onPinTap: () => _openMapPicker(context, ref, state),
            ),
        ],
      ),
    );
  }

  Future<void> _openMapPicker(
    BuildContext context,
    WidgetRef ref,
    FulfillmentState state,
  ) async {
    final result = await Navigator.of(context).push<FulfillmentLocation>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => MapPickerScreen(
          initial: state.location?.latlng,
        ),
      ),
    );
    if (result != null) {
      ref.read(fulfillmentProvider.notifier).setLocation(result);
    }
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Toggle
// ──────────────────────────────────────────────────────────────────────────────

class _FulfillmentToggle extends StatelessWidget {
  const _FulfillmentToggle({
    required this.selected,
    required this.onSelect,
  });

  final FulfillmentType selected;
  final ValueChanged<FulfillmentType> onSelect;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleOption(
              label: 'Pickup',
              icon: Icons.storefront_outlined,
              isSelected: selected == FulfillmentType.pickup,
              isFirst: true,
              onTap: () => onSelect(FulfillmentType.pickup),
            ),
          ),
          Expanded(
            child: _ToggleOption(
              label: 'Delivery',
              icon: Icons.local_shipping_outlined,
              isSelected: selected == FulfillmentType.delivery,
              isFirst: false,
              onTap: () => onSelect(FulfillmentType.delivery),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isFirst,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isFirst;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final radius = isFirst
        ? const BorderRadius.horizontal(left: Radius.circular(9))
        : const BorderRadius.horizontal(right: Radius.circular(9));

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: 52,
        decoration: BoxDecoration(
          color: isSelected ? cs.primary : Colors.transparent,
          borderRadius: radius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: tt.labelLarge?.copyWith(
                color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Pickup content
// ──────────────────────────────────────────────────────────────────────────────

class _PickupInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: cs.primaryContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.storefront_outlined, color: cs.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kukunin ko sa supplier',
                style: tt.bodyMedium?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Ikaw mismo ang kukuha ng order sa bodega ng supplier.',
                style: tt.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Delivery content
// ──────────────────────────────────────────────────────────────────────────────

class _DeliveryInfo extends StatelessWidget {
  const _DeliveryInfo({required this.state, required this.onPinTap});

  final FulfillmentState state;
  final VoidCallback onPinTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    if (!state.hasLocation) {
      return _PinCta(onTap: onPinTap);
    }

    final loc = state.location!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_pin, color: cs.error, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.addressLabel,
                    style: tt.bodyMedium?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${loc.latlng.latitude.toStringAsFixed(5)}, '
                    '${loc.latlng.longitude.toStringAsFixed(5)}',
                    style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ChangePinButton(onTap: onPinTap),
      ],
    );
  }
}

class _PinCta extends StatelessWidget {
  const _PinCta({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.primaryContainer.withValues(alpha: 0.28),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: cs.primary.withValues(alpha: 0.46),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.add_location_alt_outlined, color: cs.primary, size: 26),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I-pin ang iyong lokasyon',
                    style: tt.bodyMedium?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'I-tap para buksan ang mapa at piliin kung saan ihahatid.',
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: cs.primary),
          ],
        ),
      ),
    );
  }
}

class _ChangePinButton extends StatelessWidget {
  const _ChangePinButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: cs.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit_location_alt_outlined, size: 16, color: cs.onSurface),
            const SizedBox(width: 6),
            Text(
              'Baguhin ang pin',
              style: tt.labelMedium?.copyWith(color: cs.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
