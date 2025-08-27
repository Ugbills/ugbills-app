import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class InsufficientFunds extends StatelessWidget {
  const InsufficientFunds({super.key});

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
                "Insufficient Balance",
                style: TextStyle(
                  color: ZealPalette.errorRed,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "You don't have enough balance to complete this transfer.",
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
