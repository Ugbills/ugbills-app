import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/send/details.dart';
import 'package:zeelpay/screens/user/trade/details.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/themes/palette.dart';

class CryptoSentSuccessfully extends StatelessWidget {
  final String title, body;
  const CryptoSentSuccessfully(
      {super.key, required this.title, required this.body});

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
            Image.asset(ZeelPng.done),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ZealPalette.primaryPurple),
            ),
            Text(
              body,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
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
                    builder: (_) => const CryptoTransactionDetails(
                        cryptoCoinLogo: ZeelPng.tether,
                        amount: "₦15,000.00",
                        transactionID: "#2D94ty823",
                        dateAndTime: "Mar 10 2023, 2:33PM",
                        usdAmount: "\$10",
                        tokenAmount: "10 USDT",
                        token: "USDT",
                        type: "Buy Crypto",
                        usdtAddress: "0x93490355344433443",
                        fee: "₦10.00"),
                  ),
                );
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
