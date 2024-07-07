import 'package:flutter/material.dart';
import 'package:zeelpay/screens/auth/reset/new_password_screen.dart';
import 'package:zeelpay/screens/user/dashboard/dashboard.dart';
import 'package:zeelpay/screens/widgets/images_widget.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({super.key});

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
                      Image.asset("assets/images/saved.png",
                          height: 224.0, width: 224.0),
                      const ZeelTitleText(
                        text: "Awesome!",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                          text:
                              "You have successfully created your account, now check it out and proceed to KYC verification.",
                          center: TextAlign.center),
                      const SizedBox(height: 50.0),

                      const SizedBox(height: 20.0), // Add this line to the code
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelAltButton(
                                text: "Skip KYC",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DashBoardScreen()));
                                },
                              ),
                              const SizedBox(height: 20.0),
                              ZeelButton(
                                text: "Continue",
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
