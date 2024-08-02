import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/send/bank_transaction_details.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/themes/palette.dart';

class SentSuccessfully extends StatelessWidget {
  final String title, body;
  const SentSuccessfully({super.key, required this.title, required this.body});

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
                    builder: (_) => const BankTransactionDetails(
                      bankLogo: ZeelPng.firstbank,
                      amount: "₦10,000",
                      transactionID: "#2D94ty823",
                      dateAndTime: "Mar 10 2023, 2:33PM",
                      bankName: "First Bank of Nigeria",
                      accountName: "243802003835",
                      accountNumber: "243802003835",
                      fee: "₦10.00",
                      note: "None",
                    ),
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
