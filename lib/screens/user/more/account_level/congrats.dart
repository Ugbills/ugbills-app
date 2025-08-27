import 'package:flutter/material.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/screens/account_screen.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class Congrats extends StatelessWidget {
  const Congrats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/images/zeel-top-logo.png"),
              const Spacer(),
              Image.asset("assets/images/congrats.png"),
              const ZeelTitleText(text: "Congratulations!"),
              const Text(
                "Your BVN verification request has been submitted successfully. You will be notified once your BVN has been verified.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              ZeelButton(
                text: "Back",
                onPressed: () {
                  Go.to(const AccountScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
