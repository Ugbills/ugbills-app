import 'package:flutter/material.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/screens/user/user.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class SentSuccessfully extends StatelessWidget {
  final String title, body;
  final Widget nextPage;
  const SentSuccessfully(
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
        leadingWidth: 100,
        forceMaterialTransparency: true,
      ),
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
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : ZealPalette.primaryBlue,
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
              text: "Done",
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
