import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeelpay/helpers/forms/validators.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CreateAccountScreen extends ConsumerWidget {
  CreateAccountScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    var isloading = ref.watch(isLoadingProvider);
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
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ZeelTextFieldTitle(text: "Username or Email"),

                            ZeelTextField(
                              enabled: true,
                              validator: emailValidator,
                              controller: emailController,
                              hint: "Enter your username or email",
                            ),
                            const SizedBox(height: 20.0),
                            const ZeelTextFieldTitle(text: "Password"),

                            PassWordFormField(
                                controller: passwordController,
                                hint: "Create a secure password"),

                            const SizedBox(
                                height: 20.0), // Add this line to the code
                            const ZeelTextFieldTitle(text: "Confirm Password"),
                            PassWordFormField(
                                controller: confirmPasswordController,
                                validator: confirmPasswordValidator,
                                hint: "Re-enter your password"),

                            const SizedBox(
                                height: 20.0), // Add this line to the code
                            const ZeelTextFieldTitle(
                                text: "Referral code (Optional)"),

                            TextField(
                              decoration: InputDecoration(
                                  hintText: "Enter referral code",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                text: "Next",
                                isLoading: isloading,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {}
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

  //validator for confirm password
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null; // Indicates that the input is valid
  }
}
