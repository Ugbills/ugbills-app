import 'package:flutter/material.dart';
import 'package:zeelpay/screens/auth/create/verify_otp_screen.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

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
            child: Center(child: Text("2 of 2")),
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
                        text: "Profile Information",
                      ),

                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text:
                            "Provide the correct information below to complete your account creation.",
                      ),
                      const SizedBox(height: 50.0),
                      const ZeelTextFieldTitle(text: "Username"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "@",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      const SizedBox(height: 20.0),
                      const ZeelTextFieldTitle(text: "Full Name"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "Enter your full name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                      const SizedBox(height: 20.0), // Add this line to the code
                      const ZeelTextFieldTitle(text: "Phone Number"),

                      TextField(
                        decoration: InputDecoration(
                            hintText: "Enter your phone number",
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
                                text: "Create Account",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VerifyOtpScreen()));
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
