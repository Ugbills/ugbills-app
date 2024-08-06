import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class CheckQuality extends StatefulWidget {
  const CheckQuality({super.key});

  @override
  State<CheckQuality> createState() => _CheckQualityState();
}

class _CheckQualityState extends State<CheckQuality> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Image.asset("assets/images/lady-img.png"),
            const Spacer(flex: 2),
            const Text(
              "The image should be clear and have your face fully inside the frame before submitting.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(flex: 2),
            ZeelButton(
              text: "Submit",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SelfieSuccess()));
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                      color: isDark
                          ? ZealPalette.lightPurple
                          : ZealPalette.primaryPurple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Take a new photo",
                  style: TextStyle(
                      color: isDark ? Colors.white : ZealPalette.primaryPurple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ON FAIL

class SelfieFailed extends StatelessWidget {
  const SelfieFailed({super.key});

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
                "Please take another selfie with better lighting condition.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(flex: 2),
              ZeelButton(
                text: "Take a new photo",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ON SUCCESS

class SelfieSuccess extends StatelessWidget {
  const SelfieSuccess({super.key});

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
                "Your identity verification request has been submitted successfully for a tier 3 upgrade. ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(flex: 3),
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
      ),
    );
  }
}
