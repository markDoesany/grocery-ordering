import 'package:flutter/material.dart';
import '../../../../shared/utils/mock_actions.dart';

/// Sticky top app bar: search icon | centered title | tune icon.
/// Matches HTML header: bg=surfaceContainerLowest, border-b-2 primary.
class HomeTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopAppBar({
    super.key,
    required this.title,
    this.onSearchTap,
    this.onFilterTap,
  });

  final String title;
  final VoidCallback? onSearchTap;
  final VoidCallback? onFilterTap;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.98),
        border: Border(
          bottom: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.62)),
        ),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            _IconButton(icon: Icons.search, onTap: onSearchTap),
            Expanded(
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: tt.labelLarge?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  fontSize: 14,
                ),
              ),
            ),
            _IconButton(icon: Icons.tune, onTap: onFilterTap),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: 44,
      height: 44,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () => showMockSnack(context, 'Action unavailable'),
        child: Icon(icon, color: cs.primary),
      ),
    );
  }
}
