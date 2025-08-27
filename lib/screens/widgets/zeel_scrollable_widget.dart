import 'package:flutter/material.dart';

class ZeelScrollable extends StatelessWidget {
  final Widget child;
  final bool? hasScrollBody;
  final bool? reverse;
  const ZeelScrollable(
      {super.key,
      required this.child,
      this.hasScrollBody = false,
      this.reverse = true});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: reverse!,
        slivers: [
          SliverFillRemaining(hasScrollBody: hasScrollBody!, child: child)
        ]);
  }
}
