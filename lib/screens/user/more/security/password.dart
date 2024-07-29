import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/more/success.dart';
import 'package:zeelpay/screens/user/user.dart';
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
                    ),
                    const ZeelTextFieldTitle(text: "New Password"),
                    inputField(
                      newPasswordController,
                    ),
                    const ZeelTextFieldTitle(text: "Confirm Password"),
                    inputField(
                      confirmPasswordController,
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

Widget inputField(TextEditingController controller, {bool obscure = true}) {
  return Column(
    children: [
      TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: ZealPalette.darkerGrey,
            ),
          ),
          suffixIcon: const Icon(Icons.remove_red_eye_outlined),
        ),
      ),
      const SizedBox(height: 24),
    ],
  );
}

// class UpdatedSuccessfully extends StatelessWidget {
//   const UpdatedSuccessfully({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             const Spacer(),
//             Image.asset("assets/images/sent.png"),
//             const ZeelTitleText(text: "Updated"),
//             const Text(
//               "Your password has been updated successfully and should be used on next login.",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.grey),
//             ),
//             const Spacer(),
//             ZeelButton(
//               text: "Back",
//               onPressed: () {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (_) => const UserScreen()));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
