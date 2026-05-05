import 'package:flutter/material.dart';

class AppScrollView extends StatelessWidget {
  const AppScrollView({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 24),
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: padding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }
}
