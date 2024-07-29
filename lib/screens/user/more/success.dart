import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/themes/palette.dart';

class Success extends StatelessWidget {
  final String title, body, button;
  final String? secondButton;
  final Widget? button2;
  const Success({
    super.key,
    required this.title,
    required this.body,
    this.button = "Back",
    this.secondButton,
    this.button2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Image.asset(ZeelPng.done),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ZealPalette.primaryPurple),
            ),
            Text(
              body,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            ZeelButton(
              text: button,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const UserScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
