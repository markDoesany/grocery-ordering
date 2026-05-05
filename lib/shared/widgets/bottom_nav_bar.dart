import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// App-wide bottom navigation bar — 5 tabs, active tab filled with primary.
/// Pass [cartBadge] to show a count badge on the cart tab.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartBadge,
  });

  final int currentIndex;
  final void Function(int index) onTap;
  final String? cartBadge;

  static const _tabs = [
    _NavTab(icon: Icons.inventory_2_outlined, label: 'Restock'),
    _NavTab(icon: Icons.search, label: 'Search'),
    _NavTab(icon: Icons.history, label: 'History'),
    _NavTab(icon: Icons.stars_outlined, label: 'Rewards'),
    _NavTab(icon: Icons.shopping_cart_outlined, label: 'Cart'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.96),
        border: Border(
          top: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.62)),
        ),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_tabs.length, (i) {
              final isCart = i == 4;
              return _NavItem(
                tab: _tabs[i],
                isActive: currentIndex == i,
                badge: isCart ? cartBadge : null,
                onTap: () => onTap(i),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavTab {
  const _NavTab({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    this.badge,
  });

  final _NavTab tab;
  final bool isActive;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final fgColor = isActive ? cs.primary : cs.onSurfaceVariant;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.selectionClick();
            onTap();
          },
          splashColor: cs.primary.withValues(alpha: 0.12),
          highlightColor: cs.primary.withValues(alpha: 0.08),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
            decoration: BoxDecoration(
              color: isActive
                  ? cs.primaryContainer.withValues(alpha: 0.62)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(tab.icon, size: isActive ? 23 : 22, color: fgColor),
                    const SizedBox(height: 2),
                    Text(
                      tab.label.toUpperCase(),
                      style: tt.labelSmall?.copyWith(
                        color: fgColor,
                        fontSize: 10,
                        fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (badge != null)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        badge!,
                        style: TextStyle(
                          color: cs.onPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
