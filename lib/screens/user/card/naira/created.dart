import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/card/dollar.dart';
import 'package:zeelpay/themes/palette.dart';

class CardCreated extends StatelessWidget {
  const CardCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DollarVirtualcard(),
                    ));
              },
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(
                    color: ZealPalette.primaryPurple,
                  )),
              child: const Text(
                "Create",
                style: TextStyle(color: ZealPalette.primaryPurple),
              ),
            ),
            const SizedBox(height: 24),
            nairaCard(ZealPalette.primaryPurple, "Dollar"),
            const SizedBox(height: 24),
            nairaCard(const Color.fromRGBO(20, 20, 20, 1), "Naira"),
          ],
        ),
      ),
    );
  }
}

Widget nairaCard(Color color, String currency) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(ZeelPng.ellipse, height: 132),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(ZeelPng.whitezeel),
              Text(
                "$currency Card",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "**** 2343",
                style: TextStyle(color: Colors.white),
              ),
              Image.asset(ZeelPng.mastercard),
            ],
          ),
        ),
      ],
    ),
  );
}
