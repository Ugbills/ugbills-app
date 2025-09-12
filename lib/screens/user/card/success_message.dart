import 'package:flutter/material.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/screens/user/user.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class SuccessMessage extends StatelessWidget {
  final String title, body;
  const SuccessMessage({super.key, required this.title, required this.body});

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
                  fontWeight: FontWeight.w700, color: ZealPalette.primaryBlue),
            ),
            Text(
              body,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            ZeelButton(
              text: "Back",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UserScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
