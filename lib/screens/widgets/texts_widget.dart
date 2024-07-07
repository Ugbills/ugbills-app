import 'package:flutter/material.dart';

class ZeelTitleText extends StatelessWidget {
  final String text;
  const ZeelTitleText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            color: Color(0xff20013A)));
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
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}
