import 'package:flutter/material.dart';
import 'package:zeelpay/screens/auth/reset/new_password_screen.dart';
import 'package:zeelpay/screens/widgets/images_widget.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class LinkSentScreen extends StatelessWidget {
  const LinkSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox.shrink(),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ZeeLlogo(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Image.asset("assets/images/lock_image.png",
                          height: 224.0, width: 224.0),
                      const ZeelTitleText(
                        text: "Reset Link Sent!",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text:
                            "Password reset instructions have been sent to your email. Please check your inbox and follow the steps to reset your password.",
                        center: TextAlign.center,
                      ),
                      const SizedBox(height: 50.0),

                      const SizedBox(height: 20.0), // Add this line to the code
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                text: "Open Mail",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NewPasswordScreen()));
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
