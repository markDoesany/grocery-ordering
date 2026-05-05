import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/cart/domain/cart_provider.dart';
import '../../../core/navigation/app_navigation.dart';
import '../../../shared/utils/mock_actions.dart';
import '../../../shared/widgets/mobile_scaffold.dart';
import '../../../shared/widgets/section_header.dart';
import 'widgets/ledger_history_section.dart';
import 'widgets/points_balance_card.dart';
import 'widgets/reward_card.dart';

/// Rewards dashboard - balance, available rewards grid, ledger history.
/// Rewards tab (index 3) active.
class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return MobileScaffold(
      currentTab: AppTab.rewards,
      cartSummary: ref.watch(cartSummaryProvider),
      backgroundColor: cs.surfaceContainerLowest,
      appBar: _RewardsAppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PointsBalanceCard(
              points: 'XXXXX',
              subtext: 'Subtext Placeholder',
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Available Rewards'),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 560 ? 3 : 2;
                    return GridView.count(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 2 ? 0.75 : 0.9,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        RewardCard(
                          title: '₱XX.XX Off Next Order',
                          cost: 'XXX PTS',
                          canRedeem: true,
                          onRedeem: () => showMockSnack(
                            context,
                            'Reward added to next order',
                          ),
                        ),
                        const RewardCard(
                          title: 'Placeholder Reward Item',
                          cost: 'XXXX PTS',
                          canRedeem: false,
                        ),
                        RewardCard(
                          title: 'Placeholder Reward Item 2',
                          cost: 'XXX PTS',
                          canRedeem: true,
                          onRedeem: () => showMockSnack(
                            context,
                            'Reward added to next order',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            LedgerHistorySection(
              onFilter: () => showMockActionSheet(
                context,
                title: 'Ledger filters',
                options: const [
                  'Points earned',
                  'Rewards redeemed',
                  'This year',
                ],
              ),
              onLoadMore: () =>
                  showMockSnack(context, 'More ledger entries loaded'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _RewardsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
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
                    title: 'Rewards menu',
                    options: const [
                      'Available rewards',
                      'Points rules',
                      'History',
                    ],
                  ),
                  child: Icon(Icons.menu, color: cs.onSurface),
                ),
              ),
              Expanded(
                child: Text(
                  'REWARDS',
                  textAlign: TextAlign.center,
                  style: tt.headlineMedium?.copyWith(color: cs.primary),
                ),
              ),
              SizedBox(
                width: 44,
                height: 44,
                child: InkWell(
                  onTap: () => showMockActionSheet(
                    context,
                    title: 'Reward filters',
                    options: const ['Redeemable', 'Lowest points', 'Newest'],
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
