// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/controllers/user/user_controller.dart';
import 'package:ugbills/helpers/storage/user.dart';
import 'package:ugbills/providers/state/biometrics_state_provider.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/more/security/password.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/services/auth_service.dart';
import 'package:ugbills/themes/palette.dart';

class SecuritySettings extends ConsumerWidget {
  const SecuritySettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(fetchMobileUserInformationProvider);

    var biometrics = ref.watch(biometricsProvider);
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Security Settings"),
        forceMaterialTransparency: true,
        leading: const ZeelBackButton(),
        leadingWidth: 100,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          settings(
              context: context,
              title: "Change Password",
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ChangePassword()))),
          user.when(
            data: (data) {
              return settings(
                  context: context,
                  title: "Reset transaction Pin",
                  onTap: () {
                    ref.read(isLoadingProvider.notifier).state = true;
                    ref.read(userControllerProvider.notifier).sendResetOTP(
                        email: data!.data!.email!, context: context, ref: ref);
                  });
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? ZealPalette.lighterBlack : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Enable Fingerprint/Biometric"),
                ShadSwitch(
                    value: biometrics,
                    onChanged: (value) async {
                      var auth = await LocalAuthService.authenticateUser();
                      if (auth) {
                        UserStorage().updateBiometrics(value);
                        ref.read(biometricsProvider.notifier).state = value;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Authentication failed.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }),
              ],
            ),
          )
        ]),
      )),
    );
  }
}

Widget settings(
    {required BuildContext context,
    required String title,
    void Function()? onTap}) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? ZealPalette.lighterBlack : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
