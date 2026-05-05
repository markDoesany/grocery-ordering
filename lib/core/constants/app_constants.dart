class AppConstants {
  AppConstants._();

  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String checkoutRoute = '/checkout';
  static const String cartRoute = '/cart';
  static const String orderSummaryRoute = '/order-summary';
  static const String orderDetailsRoute = '/order-details';
  static const String inventoryRoute = '/inventory';
  static const String searchRoute = '/search';
  static const String rewardsRoute = '/rewards';

  static const Duration splashMinDuration = Duration(milliseconds: 1500);
  static const Duration networkTimeout = Duration(seconds: 10);
}
