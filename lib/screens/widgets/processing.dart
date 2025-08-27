import 'package:flutter/material.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ProcesssingScreen extends StatelessWidget {
  final String title, body;
  final Widget nextPage;
  const ProcesssingScreen(
      {super.key,
      required this.title,
      required this.body,
      required this.nextPage});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        forceMaterialTransparency: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              ZeelPng.processing,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : ZealPalette.primaryPurple,
              ),
            ),
            Text(
              body,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            ZeelButton(
              // color: Colors.transparent,
              // borderColor: true,
              text: "View Transaction",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => nextPage,
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
