import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/repository/auth_repository.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class NewPasswordScreen extends ConsumerWidget {
  final String email;
  NewPasswordScreen({super.key, required this.email});

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isloading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
                  child: Form(
                    key: formKey,
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
                        const ZeelTextFieldTitle(text: "OTP"),
                        ZeelTextField(
                          enabled: true,
                          controller: otpController,
                          hint: "Enter your OTP",
                          validator: otpValidator,
                        ),
                        const ZeelTextFieldTitle(text: "Password"),

                        PassWordFormField(
                          hint: "Create a secure password",
                          validator: passwordValidator,
                          controller: passwordController,
                        ),
                        const SizedBox(height: 20.0),
                        const ZeelTextFieldTitle(text: "Confirm Password"),
                        PassWordFormField(
                            controller: confirmPasswordController,
                            validator: confirmPasswordValidator,
                            hint: "Re-enter your password"),
                        const SizedBox(
                            height: 20.0), // Add this line to the code
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ZeelButton(
                              isLoading: isloading,
                              text: "Reset Password",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthRepository().resetPassword(
                                      context: context,
                                      email: email,
                                      password: passwordController.text,
                                      code: otpController.text,
                                      ref: ref);
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null; // Indicates that the input is valid
  }
}
