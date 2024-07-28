import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-3/selfie.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';

class EnterAddress extends StatelessWidget {
  const EnterAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ZeelTextFieldTitle(text: "House Address"),
              const SizedBox(height: 6),
              const ZeelTextField(hint: "Enter your address", enabled: true),
              const Spacer(),
              ZeelButton(
                text: "Continue",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const TakeASelfie()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
