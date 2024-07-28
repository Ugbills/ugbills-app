import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/themes/palette.dart';

class StatementError extends StatelessWidget {
  const StatementError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset("assets/images/zeel-top-logo.png"),
              const Spacer(),
              Image.asset("assets/images/failed.png"),
              const Text(
                "Failed!",
                style: TextStyle(
                  color: ZealPalette.errorRed,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "An error occurred while generating your account statement. Please try again later.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              ZeelButton(
                text: "Try Again",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
