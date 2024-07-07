import 'package:flutter/material.dart';
import 'package:zeelpay/screens/auth/reset/password_saved_screen.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ZeelBackButton(),
        ),
      ),
      body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ZeelTitleText(
                        text: "Reset Your Password",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text: "Create a new secure password for your account",
                      ),
                      const SizedBox(height: 50.0),
                      const ZeelTextFieldTitle(text: "Password"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "******",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      const SizedBox(height: 20.0),
                      const ZeelTextFieldTitle(text: "Confirm Password"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "******1",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      const SizedBox(height: 20.0), // Add this line to the code
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                text: "Reset Password",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PassswordSavedScreen()));
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
