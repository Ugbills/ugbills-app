import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zeelpay/controllers/user/user_controller.dart';
import 'package:zeelpay/helpers/forms/validators.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class ChangePassword extends StatefulHookConsumerWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final pendingPasswordChange = useState<Future<void>?>(null);
    final isLoading = useFuture(pendingPasswordChange.value).connectionState ==
        ConnectionState.waiting;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security Settings"),
        forceMaterialTransparency: true,
        leading: const ZeelBackButton(),
        leadingWidth: 100,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      const ZeelTextFieldTitle(text: "Current Password"),
                      PassWordFormField(
                          controller: currentPasswordController,
                          validator: passwordValidator,
                          hint: "Enter your current password"),
                      const ZeelTextFieldTitle(
                        text: "New Password",
                      ),
                      PassWordFormField(
                          controller: newPasswordController,
                          validator: passwordValidator,
                          hint: "Enter your new password"),
                      const ZeelTextFieldTitle(text: "Confirm Password"),
                      PassWordFormField(
                          controller: confirmPasswordController,
                          validator: confirmPasswordValidator,
                          hint: "Confirm your new password"),
                    ],
                  ),
                ),
              ),
              ZeelButton(
                text: "Update",
                isLoading: isLoading,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var future = ref
                        .read(userControllerProvider.notifier)
                        .updatePassword(
                          ref: ref,
                            context: context,
                            currentPassword: currentPasswordController.text,
                            newPassword: newPasswordController.text);
                    pendingPasswordChange.value = future;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //confirm password validator
  String? confirmPasswordValidator(String? value) {
    if (value != confirmPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }
}
