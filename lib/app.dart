import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/router.dart';
import 'core/theme/theme_provider.dart';
import 'shared/widgets/mobile_scroll_behavior.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Grocery',
      theme: theme,
      routerConfig: router,
      scrollBehavior: const MobileScrollBehavior(),
      debugShowCheckedModeBanner: false,
    );
  }
}
