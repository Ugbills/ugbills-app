import 'package:flutter/material.dart';

class ZeeLlogo extends StatelessWidget {
  const ZeeLlogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Image.asset(isDark ? "assets/images/ug.png" : "assets/images/ug.png",
        height: 100.0, width: 100.0);
  }
}
