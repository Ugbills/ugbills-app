import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/themes/palette.dart';

class StatementDone extends StatelessWidget {
  const StatementDone({super.key});

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
            Image.asset("assets/images/sent.png"),
            const Text(
              "Done",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ZealPalette.primaryPurple),
            ),
            const Text(
              "Your account statement has been successfully generated and sent to your email. Check your inbox for the details.",
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            ZeelButton(
              text: "Back",
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
