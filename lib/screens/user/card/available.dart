import 'package:flutter/material.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/card/dollar/actions.dart';
import 'package:zeelpay/screens/user/card/modal.dart';
import 'package:zeelpay/screens/user/card/naira/actions.dart';
import 'package:zeelpay/themes/palette.dart';

class AvailableCards extends StatelessWidget {
  const AvailableCards({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            FilledButton(
              onPressed: () {
                CardModal.showModal(context);
              },
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                    color: isDark
                        ? ZealPalette.lightPurple
                        : ZealPalette.primaryPurple,
                  )),
              child: Text(
                "Create",
                style: TextStyle(
                    color: isDark ? Colors.white : ZealPalette.primaryPurple),
              ),
            ),
            const SizedBox(height: 24),
            availableCard(ZealPalette.primaryPurple, "Dollar",
                const DollarVirtualCardActions(), context),
            const SizedBox(height: 24),
            availableCard(const Color.fromRGBO(20, 20, 20, 1), "Naira",
                const NairaVirtualCardActions(), context),
          ],
        ),
      ),
    );
  }
}

Widget availableCard(
    Color color, String currency, Widget route, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => route,
          ));
    },
    child: Container(
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
    ),
  );
}
