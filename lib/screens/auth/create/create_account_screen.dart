import 'package:flutter/material.dart';
import 'package:zeelpay/screens/auth/create/profile_information_screen.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ZeelBackButton(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: Text("1 of 2")),
          ),
        ],
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
                        text: "Create Account",
                      ),

                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text:
                            "Create your account and unlock a world of financial possibilities.",
                      ),
                      const SizedBox(height: 50.0),
                      const ZeelTextFieldTitle(text: "Username or Email"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "Enter your email address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      const SizedBox(height: 20.0),
                      const ZeelTextFieldTitle(text: "Password"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "Create a secure password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      const SizedBox(height: 20.0), // Add this line to the code
                      const ZeelTextFieldTitle(text: "Confirm Password"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "Re-enter your password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      const SizedBox(height: 20.0), // Add this line to the code
                      const ZeelTextFieldTitle(
                          text: "Referral code (Optional)"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "Enter referral code",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                text: "Next",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileInfoScreen()));
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
