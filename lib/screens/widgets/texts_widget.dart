import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ZeelTitleText extends StatelessWidget {
  final String text;
  const ZeelTitleText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      text,
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w900,
        color: isDark ? Colors.white : const Color(0xff1C41AB),
      ),
    );
  }
}

class ZeelText extends StatelessWidget {
  final String text;
  final TextAlign? center;
  const ZeelText({super.key, this.center, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
      textAlign: center,
    );
  }
}

class ZeelTextFieldTitle extends StatelessWidget {
  final String text;
  const ZeelTextFieldTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: ShadTheme.of(context).textTheme.h1.copyWith(fontSize: 16),
    );
  }
}
