import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/repository/auth_repository.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
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
                        child: ZeelTextField(
                          enabled: true,
                          controller: emailController,
                          validator: emailValidator,
                          hint: "Enter your email address",
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
                                  if (formKey.currentState!.validate()) {
                                    AuthRepository().forgotPassword(
                                        ref: ref,
                                        email: emailController.text,
                                        context: context);
                                  }
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
