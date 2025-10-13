import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/repository/auth_repository.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var isloading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
          reverse: true,
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
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ZeelTextFieldTitle(text: "Username"),
                            ZeelTextField(
                              enabled: true,
                              validator: usernameValidator,
                              controller: userNameController,
                              hint: "@",
                            ),
                            const ZeelTextFieldTitle(text: "Full Name"),
                            ZeelTextField(
                              enabled: true,
                              controller: fullNameController,
                              validator: fullNameValidator,
                              hint: "Enter your full name",
                            ),
                            const ZeelTextFieldTitle(text: "Email"),
                            ZeelTextField(
                              enabled: true,
                              validator: emailValidator,
                              controller: emailController,
                              hint: "Enter your email",
                            ),

                            const ZeelTextFieldTitle(text: "Phone Number"),
                            ZeelTextField(
                              enabled: true,
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController,
                              maxLength: 11,
                              validator: phoneNumberValidator,
                              hint: "Enter your phone number",
                            ),

                            const ZeelTextFieldTitle(text: "Password"),

                            PassWordFormField(
                                onChanged: (value) => setState(() {}),
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
                              height: 5,
                            ),

                            StrengthWidget(
                                title:
                                    "Password strength: ${evaluatePasswordStrength(passwordController.text)}",
                                passed: (evaluatePasswordStrength(
                                            passwordController.text) ==
                                        "Good" ||
                                    (evaluatePasswordStrength(
                                            passwordController.text) ==
                                        "Medium"))),
                            const SizedBox(
                              height: 5,
                            ),
                            StrengthWidget(
                              title: "At least 8 characters",
                              passed: (passwordController.text.length >= 8),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            StrengthWidget(
                              title: "Contain a number or symbol",
                              passed: (passwordController.text
                                  .contains(RegExp(r'[0-9!@#\$&*~]'))),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ZeelTextFieldTitle(
                          text: "Referral code (Optional)"),
                      ZeelTextField(
                        enabled: true,
                        controller: referralController,
                        hint: "Enter referral code",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                text: "SignUp",
                                isLoading: isloading,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (evaluatePasswordStrength(
                                                passwordController.text) ==
                                            "Good" ||
                                        evaluatePasswordStrength(
                                                passwordController.text) ==
                                            "Medium") {
                                      AuthRepository().signUp(
                                          fullName: fullNameController.text,
                                          userName: userNameController.text,
                                          phoneNumber:
                                              phoneNumberController.text,
                                          referralCode: referralController.text,
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          ref: ref);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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

class StrengthWidget extends StatelessWidget {
  final String title;
  final bool? passed;
  const StrengthWidget({
    super.key,
    required this.title,
    this.passed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: passed! ? const Color(0xff14A44D) : Colors.red,
              shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 5,
        ),
        ZeelText(text: title)
      ],
    );
  }
}

String evaluatePasswordStrength(String password) {
  int score = 0;

  // Criteria for scoring password strength
  if (password.length >= 8) score++; // At least 8 characters
  if (password.contains(RegExp(r'[A-Z]'))) score++; // Contains uppercase letter
  if (password.contains(RegExp(r'[a-z]'))) score++; // Contains lowercase letter
  if (password.contains(RegExp(r'[0-9]'))) score++; // Contains a number
  if (password.contains(RegExp(r'[!@#\$&*~]'))) {
    score++; // Contains special character
  }

  // Determine password strength based on score
  if (score <= 2) {
    return "Weak";
  } else if (score == 3 || score == 4) {
    return "Medium";
  } else if (score == 5) {
    return "Good";
  }

  // Default fallback
  return "Weak";
}
