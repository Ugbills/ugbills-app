// ignore_for_file: use_build_context_synchronously

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/controllers/user/user_controller.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/helpers/storage/user.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/more/security/pin.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class OPTScreen extends ConsumerWidget {
  OPTScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(fetchUserInformationProvider);
    //show dialog to reset pin
    Dialog alert = const Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(child: CircularProgressIndicator()));

    ref.listen(isLoadingProvider, (previous, next) {
      if (next == true) {
        showDialog(
            barrierColor: const Color.fromARGB(39, 0, 0, 0),
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return alert;
            });
      }
      if (next == false) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Security Settings"),
        forceMaterialTransparency: true,
        leading: const ZeelBackButton(),
        leadingWidth: 100,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ZeelTitleText(text: "OTP Verification"),
              Text(
                "An OTP has been sent to your registered email address. Please input it below.",
                style: TextStyle(
                  color: FlexThemeData.light().textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: controller,
                  validator: otpValidator,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: ZealPalette.darkerGrey,
                      ),
                    ),
                    hintText: "Enter OTP",
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Did not receive an OTP?  "),
                  user.when(
                    data: (data) {
                      return InkWell(
                        onTap: () {
                          ref.read(isLoadingProvider.notifier).state = true;
                          ref
                              .read(userControllerProvider.notifier)
                              .sendResetOTP(
                                  email: UserStorage().getEmail(),
                                  context: context,
                                  ref: ref);
                        },
                        child: const Text("Resend",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  )
                ],
              ),
              const Spacer(),
              user.when(
                data: (data) {
                  return ZeelButton(
                    text: "Continue",
                    onPressed: () async {
                      //validate the form
                      if (!formKey.currentState!.validate()) {
                      } else {
                        //unfocus the keyboard
                        FocusScope.of(context).unfocus();
                        //DELAY FOR 1 SECOND
                        await Future.delayed(const Duration(milliseconds: 100));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ResetTransactionPin(
                                      otp: controller.text,
                                      email: data!.data!.email!,
                                    )));
                      }
                    },
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (error, stack) => Text('Error: $error'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
