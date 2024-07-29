import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/send/details.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/themes/palette.dart';

class SentSuccessfully extends StatelessWidget {
  const SentSuccessfully({super.key});

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
              "Sent",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ZealPalette.primaryPurple),
            ),
            const Text(
              "You have successfully sent ₦10,000 to Mary Doe.",
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            ZeelButton(
              color: Colors.transparent,
              borderColor: true,
              text: "View Transaction",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TransactionDetails()));
              },
            ),
            const SizedBox(height: 12),
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
