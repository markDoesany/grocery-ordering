import 'package:flutter/material.dart';
import '../../../../../shared/widgets/section_header.dart';

/// Points transaction history list with Load More button.
class LedgerHistorySection extends StatelessWidget {
  const LedgerHistorySection({super.key, this.onFilter, this.onLoadMore});

  final VoidCallback? onFilter;
  final VoidCallback? onLoadMore;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Ledger History',
          trailing: GestureDetector(
            onTap: onFilter,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 44,
              height: 44,
              child: Icon(Icons.filter_list, size: 20, color: cs.onSurface),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: cs.outlineVariant, width: 2),
          ),
          child: Column(
            children: [
              const _HistoryItem(
                label: 'ORDER #0001',
                date: 'Jan 1, 2025',
                points: '+12 PTS',
                isGain: true,
              ),
              Divider(height: 0, thickness: 2, color: cs.outlineVariant),
              const _HistoryItem(
                label: 'Reward Redemption',
                date: 'Dec 28, 2024',
                points: '−150 PTS',
                isGain: false,
              ),
              Divider(height: 0, thickness: 2, color: cs.outlineVariant),
              const _HistoryItem(
                label: 'ORDER #0002',
                date: 'Dec 20, 2024',
                points: '+22 PTS',
                isGain: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onLoadMore,
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: cs.surfaceContainerLowest,
              border: Border.all(color: cs.primary, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              'LOAD MORE ENTRIES',
              style: tt.labelLarge?.copyWith(
                color: cs.primary,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({
    required this.label,
    required this.date,
    required this.points,
    required this.isGain,
  });

  final String label;
  final String date;
  final String points;
  final bool isGain;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: tt.bodyMedium?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: tt.labelLarge?.copyWith(
              color: isGain ? cs.onTertiaryContainer : cs.secondaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
