import 'package:flutter/material.dart';

class ZeelScrollable extends StatelessWidget {
  final Widget child;
  const ZeelScrollable({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: true,
        slivers: [SliverFillRemaining(hasScrollBody: false, child: child)]);
  }
}
