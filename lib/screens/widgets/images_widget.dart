import 'package:flutter/material.dart';

class ZeeLlogo extends StatelessWidget {
  const ZeeLlogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Image.asset(
        isDark
            ? "assets/images/zeelpay-top-white.png"
            : "assets/images/logo.png",
        height: 20.0,
        width: 84.0);
  }
}
