import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/themes/palette.dart';

class TvTransactionDetails extends StatelessWidget {
  final String tvLogo,
      amount,
      transactionID,
      dateAndTime,
      smartcardNumber,
      serviceProvider,
      plan,
      fee;
  const TvTransactionDetails({
    super.key,
    required this.tvLogo,
    required this.amount,
    required this.transactionID,
    required this.dateAndTime,
    required this.smartcardNumber,
    required this.serviceProvider,
    required this.plan,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                color: ZealPalette.primaryPurple,
                image: DecorationImage(
                  image: AssetImage("assets/images/bcc.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      tvLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "₦$amount",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ZealPalette.lightGreen,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Text(
                      "Completed",
                      style: TextStyle(
                        color: ZealPalette.successGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height / 1.89,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Transaction details"),
                  const SizedBox(height: 12),
                  showDetails("Transaction ID", "#$transactionID"),
                  showDetails("Date & time", dateAndTime),
                  showDetails("Smartcard Number", smartcardNumber),
                  showDetails("Service Provider", serviceProvider),
                  showDetails("Plan", plan),
                  showDetails("Fee", "₦$fee"),
                  const Spacer(),
                  ZeelButton(
                    text: "Share Transaction",
                    onPressed: () {},
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget showDetails(String lead, String trail) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lead,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        Text(
          trail,
          style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
