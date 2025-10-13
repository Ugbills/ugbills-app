import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/repository/auth_repository.dart';
import 'package:ugbills/screens/auth/login_screen.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class RegisterScreen extends HookConsumerWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final pendingRegister = useState<Future<void>?>(null);
    final isLoading = useFuture(pendingRegister.value).connectionState ==
        ConnectionState.waiting;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        forceMaterialTransparency: true,
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
                        text: "Create Account",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text: "Sign up to start managing your finances",
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ZeelTextFieldTitle(text: "Full Name"),
                            ZeelTextField(
                              enabled: true,
                              validator: (value) => value?.isEmpty == true
                                  ? 'Full name is required'
                                  : null,
                              controller: fullNameController,
                              hint: "Enter your full name",
                            ),
                            const ZeelTextFieldTitle(text: "Username"),
                            ZeelTextField(
                              enabled: true,
                              validator: (value) => value?.isEmpty == true
                                  ? 'Username is required'
                                  : null,
                              controller: usernameController,
                              hint: "Enter your username",
                            ),
                            const ZeelTextFieldTitle(text: "Email Address"),
                            ZeelTextField(
                              enabled: true,
                              validator: emailValidator,
                              controller: emailController,
                              hint: "Enter your email",
                            ),
                            const ZeelTextFieldTitle(text: "Phone Number"),
                            ZeelTextField(
                              enabled: true,
                              validator: (value) => value?.isEmpty == true
                                  ? 'Phone number is required'
                                  : null,
                              controller: phoneController,
                              hint: "Enter your phone number",
                            ),
                            const ZeelTextFieldTitle(text: "Password"),
                            PassWordFormField(controller: passwordController),
                            const ZeelTextFieldTitle(text: "Confirm Password"),
                            PassWordFormField(
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value?.isEmpty == true)
                                  return 'Please confirm your password';
                                if (value != passwordController.text)
                                  return 'Passwords do not match';
                                return null;
                              },
                            ),
                            const ZeelTextFieldTitle(
                                text: "Referral Code (Optional)"),
                            ZeelTextField(
                              enabled: true,
                              controller: referralController,
                              hint: "Enter referral code",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                  text: "Create Account",
                                  isLoading: isLoading,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      final authRepo = AuthRepository();
                                      final future = authRepo.signUp(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        fullName: fullNameController.text,
                                        phoneNumber: phoneController.text,
                                        referralCode: referralController.text,
                                        userName: usernameController.text,
                                        ref: ref,
                                      );
                                      pendingRegister.value = future;
                                    }
                                  }),
                              const SizedBox(height: 10.0),
                              TextButton(
                                  onPressed: () {
                                    Go.to(LoginScreen());
                                  },
                                  child: Text("Already have an account? Login",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16))),
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
