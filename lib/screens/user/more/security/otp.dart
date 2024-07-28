import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/more/security/pin.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class OPTScreen extends StatelessWidget {
  const OPTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ZeelTitleText(text: "OTP Verification"),
              Text(
                "An OTP has been sent to your registered email address. Please input it below.",
                style: TextStyle(
                  color: FlexThemeData.light().textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controller,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: ZealPalette.darkerGrey,
                    ),
                  ),
                  hintText: "Enter OTP",
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Did not receive an OTP?  "),
                  InkWell(
                    onTap: () {},
                    child: const Text("Resend"),
                  ),
                ],
              ),
              const Spacer(),
              ZeelButton(
                text: "Continue",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ResetTransactionPin()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
