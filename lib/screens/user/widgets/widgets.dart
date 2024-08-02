import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ZeelNetwork extends StatelessWidget {
  final String icon;
  const ZeelNetwork({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: ShadImage(icon),
      ),
    );
  }
}

class ZeelQuickAmount extends StatelessWidget {
  final ShadThemeData theme;
  final String text;
  const ZeelQuickAmount({
    super.key,
    required this.theme,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(text, style: theme.textTheme.small),
      ),
    );
  }
}
