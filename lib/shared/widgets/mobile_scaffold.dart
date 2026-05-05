import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../features/cart/domain/cart_provider.dart';
import 'bottom_nav_bar.dart';

class MobileScaffold extends StatelessWidget {
  const MobileScaffold({
    super.key,
    required this.currentIndex,
    required this.body,
    required this.cartSummary,
    this.appBar,
    this.backgroundColor,
    this.bottom,
  });

  final int currentIndex;
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
        currentIndex: currentIndex,
        cartBadge: cartSummary.itemCount > 0 ? cartSummary.badgeText : null,
        onTap: (i) => _handleTap(context, i),
      ),
    );
  }

  void _handleTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        context.go(AppConstants.homeRoute);
      case 1:
        context.go(AppConstants.searchRoute);
      case 2:
        context.go(AppConstants.orderDetailsRoute);
      case 3:
        context.go(AppConstants.rewardsRoute);
      case 4:
        context.go(AppConstants.cartRoute);
    }
  }
}
