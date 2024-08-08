import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeelpay/controllers/auth/auth_controller.dart';
import 'package:zeelpay/helpers/forms/validators.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

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
                        text: "Forgot Password",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text:
                            "Enter your email address to receive password reset instructions.",
                      ),
                      const SizedBox(height: 50.0),
                      const ZeelTextFieldTitle(text: "Email"),
                      Form(
                        key: formKey,
                        child: TextFormField(
                          controller: emailController,
                          validator: emailValidator,
                          decoration: InputDecoration(
                              hintText: "Enter your email address",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),

                      const SizedBox(height: 20.0), // Add this line to the code
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelButton(
                                isLoading: isloading,
                                text: "Send Rest Link",
                                onPressed: () {
                                  AuthController().forgotPassword(
                                      email: emailController.text,
                                      ref: ref,
                                      formkey: formKey);
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
