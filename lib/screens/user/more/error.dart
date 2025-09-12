import 'package:flutter/material.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class Error extends StatelessWidget {
  final String title, body, button;
  const Error(
      {super.key,
      required this.title,
      required this.body,
      required this.button});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset("assets/images/ug-top-logo.png"),
              const Spacer(),
              Image.asset("assets/images/failed.png"),
              Text(
                title,
                style: const TextStyle(
                  color: ZealPalette.errorRed,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                body,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              ZeelButton(
                text: button,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
