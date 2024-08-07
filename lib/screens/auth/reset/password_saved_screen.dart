import 'package:flutter/material.dart';
import 'package:zeelpay/screens/auth/login_screen.dart';
import 'package:zeelpay/screens/widgets/images_widget.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class PassswordSavedScreen extends StatelessWidget {
  const PassswordSavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Image.asset("assets/images/saved.png",
                          height: 224.0, width: 224.0),
                      const ZeelTitleText(
                        text: "Password Saved",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                          text: "You have successfully changed your password",
                          center: TextAlign.center),
                      const SizedBox(height: 50.0),

                      const SizedBox(height: 20.0), // Add this line to the code
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                text: "Log in",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
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
