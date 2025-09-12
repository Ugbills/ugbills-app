import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/repository/auth_repository.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class VerifyOtpScreen extends ConsumerWidget {
  final String email;
  VerifyOtpScreen({super.key, required this.email});

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isloading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        forceMaterialTransparency: true,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ZeelBackButton(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: Text("2 of 2")),
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
                        text: "Verification",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text:
                            "Enter the 4-digit OTP code sent to your email to verify your account.",
                      ),
                      const SizedBox(height: 50.0),
                      ZeelTextField(
                        enabled: true,
                        validator: otpValidator,
                        hint: "Enter OTP",
                        controller: codeController,
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: GestureDetector(
                          onTap: () => AuthRepository().resendVerifyEmail(
                              context: context, email: email, ref: ref),
                          child: const Text(
                            "Did not receive the mail? Resend",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ZeelButton(
                            isLoading: isloading,
                            text: "Verify",
                            onPressed: () {
                              AuthRepository().verifyEmail(
                                  context: context,
                                  email: email,
                                  code: codeController.text,
                                  ref: ref);
                            },
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
