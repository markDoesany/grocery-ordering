import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery/features/cart/presentation/cart_screen.dart';

void main() {
  testWidgets('Cart screen lays out without render errors', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ProviderScope(child: CartScreen())),
    );

    expect(find.text('MY CART'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
