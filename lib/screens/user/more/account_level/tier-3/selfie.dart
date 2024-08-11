import 'package:flutter/material.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-3/quality.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class TakeASelfie extends StatelessWidget {
  const TakeASelfie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Image.asset("assets/images/selfie.png"),
            const SizedBox(height: 10),
            const ZeelTitleText(text: "Take a Selfie"),
            const SizedBox(height: 10),
            const Text(
              "This will help us identify who owns this account.",
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(flex: 2),
            ZeelButton(
              text: "Take a Selfie",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CheckQuality(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
