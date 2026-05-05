import 'package:flutter_test/flutter_test.dart';
import 'package:grocery/features/cart/domain/cart_provider.dart';

void main() {
  test('cart controller updates quantities', () {
    final controller = CartController();

    controller.clear();
    controller.increment('sku-001');
    controller.increment('sku-001');
    controller.decrement('sku-001');

    expect(controller.state, {'sku-001': 1});

    controller.remove('sku-001');

    expect(controller.state, isEmpty);
  });
}
