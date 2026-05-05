import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';

enum AppTab {
  restock,
  search,
  history,
  rewards,
  cart,
}

extension AppTabRoute on AppTab {
  int get index => switch (this) {
        AppTab.restock => 0,
        AppTab.search => 1,
        AppTab.history => 2,
        AppTab.rewards => 3,
        AppTab.cart => 4,
      };

  String get route => switch (this) {
        AppTab.restock => AppConstants.homeRoute,
        AppTab.search => AppConstants.searchRoute,
        AppTab.history => AppConstants.orderDetailsRoute,
        AppTab.rewards => AppConstants.rewardsRoute,
        AppTab.cart => AppConstants.cartRoute,
      };

  static AppTab fromIndex(int index) => switch (index) {
        0 => AppTab.restock,
        1 => AppTab.search,
        2 => AppTab.history,
        3 => AppTab.rewards,
        4 => AppTab.cart,
        _ => AppTab.restock,
      };
}

void goToTab(BuildContext context, AppTab currentTab, int nextIndex) {
  final nextTab = AppTabRoute.fromIndex(nextIndex);
  if (nextTab == currentTab) return;

  context.go(nextTab.route);
}

void popOrGo(BuildContext context, String fallbackRoute) {
  if (context.canPop()) {
    context.pop();
    return;
  }

  context.go(fallbackRoute);
}
