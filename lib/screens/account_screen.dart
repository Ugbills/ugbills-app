import 'package:flutter/material.dart';
import 'package:zeelpay/screens/auth/create/create_account_screen.dart';
import 'package:zeelpay/screens/auth/login_screen.dart';
import 'package:zeelpay/screens/widgets/images_widget.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ZeeLlogo(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Image.asset("assets/images/wallet_man.png",
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.9),
                      const ZeelTitleText(
                        text: "Welcome to ZeelPay!",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text: "Manage your finances effortlessly",
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
                              ZeelAltButton(
                                text: "Create Account",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAccountScreen()));
                                },
                              ),
                              const SizedBox(height: 20.0),
                              ZeelButton(
                                text: "Log in",
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                              ),
                              const SizedBox(height: 20.0),
                              const ZeelText(
                                text:
                                    "By signing up, you agree to our Terms of Service and Privacy Policy",
                                center: TextAlign.center,
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
