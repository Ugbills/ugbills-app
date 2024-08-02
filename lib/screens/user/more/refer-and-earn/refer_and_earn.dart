import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/more/refer-and-earn/earnings.dart';
import 'package:zeelpay/themes/palette.dart';
import 'package:flutter_share/flutter_share.dart';

class ReferAndEarn extends StatelessWidget {
  const ReferAndEarn({super.key});

  Future<void> shareReferralLink() async {
    await FlutterShare.share(
      title: 'Referral Link',
      text: "https://url.com/user/me/referral_link",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Image.asset("assets/images/refer-and-earn.png"),
                  const Text(
                    "Earn extra cash with each referral",
                    style: TextStyle(
                      color: ZealPalette.primaryPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Your account statement has been successfully generated and sent to your email. Check your inbox for the details.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  referral(context),
                ],
              ),
            ),
            // const Spacer(),
            ZeelButton(
              text: "Share Referral Link",
              onPressed: shareReferralLink,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReferralEarnings()));
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: ZealPalette.primaryPurple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "View Referral Earnings",
                  style: TextStyle(color: ZealPalette.primaryPurple),
                ),
              ),
            ),
            // const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

Widget referral(BuildContext context) {
  String? referralCode = "johndoe";
  return InkWell(
    splashFactory: NoSplash.splashFactory,
    borderRadius: BorderRadius.circular(16),
    onTap: () {
      Clipboard.setData(ClipboardData(text: referralCode)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("copied to clipboard"),
          ),
        );
      });
    },
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tap to copy code",
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              Text(
                referralCode,
                style: const TextStyle(
                  fontSize: 16,
                  color: ZealPalette.primaryPurple,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: ShadImage.square(
              ZeelSvg.copy,
              size: 20.0,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ),
  );
}
