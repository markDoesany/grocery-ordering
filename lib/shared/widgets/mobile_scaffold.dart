import 'package:flutter/material.dart';
import '../../core/navigation/app_navigation.dart';
import '../../features/cart/domain/cart_provider.dart';
import 'bottom_nav_bar.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({
    super.key,
    required this.currentTab,
    required this.body,
    required this.cartSummary,
    this.appBar,
    this.backgroundColor,
    this.bottom,
  });

  final AppTab currentTab;
  final Widget body;
  final CartSummary cartSummary;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: backgroundColor ?? cs.surface,
      appBar: appBar,
      body: bottom == null
          ? body
          : Column(
              children: [
                Expanded(child: body),
                bottom!,
              ],
            ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentTab.index,
        cartBadge: cartSummary.itemCount > 0 ? cartSummary.badgeText : null,
        onTap: (i) => goToTab(context, currentTab, i),
      ),
    );
  }
}
