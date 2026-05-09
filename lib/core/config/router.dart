import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/profile_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/checkout/presentation/checkout_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/inventory/presentation/inventory_screen.dart';
import '../../features/order_details/presentation/order_details_screen.dart';
import '../../features/order_summary/presentation/order_summary_screen.dart';
import '../../features/rewards/presentation/rewards_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

/// GoRouter owned by Riverpod so it can be overridden in tests.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppConstants.splashRoute,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const SplashScreen()),
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const LoginScreen()),
      ),
      GoRoute(
        path: AppConstants.homeRoute,
        pageBuilder: (context, state) => _mobilePage(state, const HomeScreen()),
      ),
      GoRoute(
        path: AppConstants.checkoutRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const CheckoutScreen()),
      ),
      GoRoute(
        path: AppConstants.cartRoute,
        pageBuilder: (context, state) => _mobilePage(state, const CartScreen()),
      ),
      GoRoute(
        path: AppConstants.orderSummaryRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const OrderSummaryScreen()),
      ),
      GoRoute(
        path: AppConstants.orderDetailsRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const OrderDetailsScreen()),
      ),
      GoRoute(
        path: AppConstants.inventoryRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const InventoryScreen()),
      ),
      GoRoute(
        path: AppConstants.searchRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const SearchScreen()),
      ),
      GoRoute(
        path: AppConstants.rewardsRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const RewardsScreen()),
      ),
      GoRoute(
        path: AppConstants.profileRoute,
        pageBuilder: (context, state) =>
            _mobilePage(state, const ProfileScreen()),
      ),
    ],
  );
});

CustomTransitionPage<void> _mobilePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 240),
    reverseTransitionDuration: const Duration(milliseconds: 180),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      final offset = Tween<Offset>(
        begin: const Offset(0.04, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      return FadeTransition(
        opacity: fade,
        child: SlideTransition(position: offset, child: child),
      );
    },
  );
}
