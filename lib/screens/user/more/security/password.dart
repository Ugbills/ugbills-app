import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/more/success.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const ZeelTextFieldTitle(text: "Current Password"),
                    inputField(
                      currentPasswordController,
                      context,
                    ),
                    const ZeelTextFieldTitle(text: "New Password"),
                    inputField(
                      newPasswordController,
                      context,
                    ),
                    const ZeelTextFieldTitle(text: "Confirm Password"),
                    inputField(
                      confirmPasswordController,
                      context,
                    ),
                  ],
                ),
              ),
              ZeelButton(
                text: "Update",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Success(
                            title: "Updated",
                            body:
                                "Your password has been updated successfully and should be used on next login."),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputField(TextEditingController controller, BuildContext context,
    {bool obscure = true}) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Column(
    children: [
      TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
          fillColor: isDark ? ZealPalette.lighterBlack : Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDark ? Colors.grey : ZealPalette.darkerGrey,
            ),
          ),
          suffixIcon: const Icon(Icons.remove_red_eye_outlined),
        ),
      ),
      const SizedBox(height: 24),
    ],
  );
}
