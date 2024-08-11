import 'package:flutter/material.dart';
import 'package:zeelpay/screens/user/more/security/password.dart';
import 'package:zeelpay/screens/user/more/security/otp.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class SecuritySettings extends StatelessWidget {
  const SecuritySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security Settings"),
        leading: const ZeelBackButton(),
        leadingWidth: 100,
      ),
      body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(24), children: [
        settings(context, "Change Password", const ChangePassword()),
        settings(context, "Reset security Pin", const OPTScreen()),
        settings(
          context,
          "Reset transaction Pin",
          const OPTScreen(),
        ),
      ])),
    );
  }
}

Widget settings(BuildContext context, String title, Widget page) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? ZealPalette.lighterBlack : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
