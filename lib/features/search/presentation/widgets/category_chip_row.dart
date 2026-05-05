import 'package:flutter/material.dart';

/// Horizontally-scrollable filter chips — active chip filled primary.
class CategoryChipRow extends StatelessWidget {
  const CategoryChipRow({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (i) {
          return Padding(
            padding: EdgeInsets.only(right: i < categories.length - 1 ? 12 : 0),
            child: _CategoryChip(
              label: categories[i],
              isActive: selectedIndex == i,
              onTap: () => onSelected(i),
            ),
          );
        }),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? cs.primary : cs.surface,
          border: Border.all(
            color: isActive ? cs.primary : cs.outline,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: tt.labelLarge?.copyWith(
            color: isActive ? cs.onPrimary : cs.onSurface,
          ),
        ),
      ),
    );
  }
}
