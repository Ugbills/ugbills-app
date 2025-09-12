import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/repository/auth_repository.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class ProfileInfoScreen extends ConsumerStatefulWidget {
  final String userId;
  final String email;
  const ProfileInfoScreen(
      {super.key, required this.userId, required this.email});

  @override
  ConsumerState<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends ConsumerState<ProfileInfoScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController referralController = TextEditingController();
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
            child: Center(child: Text("2 of 2")),
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
                        text: "Profile Information",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                        text:
                            "Provide the correct information below to complete your account creation.",
                      ),
                      const SizedBox(height: 50.0),
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
                            const ZeelTextFieldTitle(text: "Phone Number"),
                            ZeelTextField(
                              enabled: true,
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController,
                              maxLength: 11,
                              validator: phoneNumberValidator,
                              hint: "Enter your phone number",
                            ),
                          ],
                        ),
                      ),
                      const ZeelTextFieldTitle(
                          text: "Referral code (Optional)"),
                      ZeelTextField(
                        enabled: true,
                        controller: referralController,
                        hint: "Enter referral code",
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ZeelButton(
                              isLoading: isloading,
                              text: "Create Account",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthRepository().completeSignUp(
                                      context: context,
                                      userId: widget.userId,
                                      email: widget.email,
                                      fullName: fullNameController.text,
                                      phoneNumber: phoneNumberController.text,
                                      userName: userNameController.text,
                                      referralCode: referralController.text,
                                      ref: ref);
                                }
                              }),
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
