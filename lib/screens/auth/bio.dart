// ignore_for_file: use_build_context_synchronously

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/controllers/user/user_controller.dart';
import 'package:ugbills/providers/state/biometrics_state_provider.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/repository/auth_repository.dart';
import 'package:ugbills/screens/user/user.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/services/auth_service.dart';
import 'package:ugbills/themes/palette.dart';

class BiometricsLoginScreen extends ConsumerStatefulWidget {
  const BiometricsLoginScreen({super.key});

  @override
  ConsumerState<BiometricsLoginScreen> createState() =>
      _BiometricsLoginScreenState();
}

class _BiometricsLoginScreenState extends ConsumerState<BiometricsLoginScreen> {
  String enteredPin = '';
  bool pinProgress = false;

  Widget numButton(int number) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          setState(
            () {
              if (enteredPin.length < 4) {
                enteredPin += number.toString();
                if (enteredPin.length == 4) {
                  AuthRepository().loginWithPin(
                    context: context,
                    ref: ref,
                    pin: enteredPin,
                  );
                }
              }
            },
          );
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 16),
          constraints: const BoxConstraints(
            maxHeight: 64,
            maxWidth: 64,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? ZealPalette.lighterBlack : Colors.white),
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 24,
              color: isDark ? Colors.grey : Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(fetchUserInformationProvider);
    var biometrics = ref.watch(biometricsProvider);

    bool isDark = Theme.of(context).brightness == Brightness.dark;
    //show loading dialog
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              user.when(
                  data: (me) => ZeelTitleText(
                      text: "Hi, ${me!.data!.firstName!.capitalize}"),
                  error: (error, stack) => const ZeelTitleText(text: "Hi"),
                  loading: () => const ZeelTitleText(text: "Hi")),
              const Text("Log in with your transaction PIN"),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) {
                      return Container(
                        margin: const EdgeInsets.all(6.0),
                        constraints: const BoxConstraints(
                          maxHeight: 64,
                          maxWidth: 64,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              isDark ? ZealPalette.lighterBlack : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: index < enteredPin.length
                                ? pinProgress
                                    ? Colors.grey
                                    : Colors.grey
                                : ZealPalette.primaryBlue.withOpacity(0),
                          ),
                        ),
                        child: index < enteredPin.length
                            ? Center(
                                child: Text(
                                  index == enteredPin.length - 1
                                      ? enteredPin[index]
                                      : '●',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ),

              user.when(
                  data: (me) => GestureDetector(
                        onTap: () {
                          ref.read(isLoadingProvider.notifier).state = true;
                          ref
                              .read(userControllerProvider.notifier)
                              .sendResetOTP(
                                  email: me!.data!.email!,
                                  context: context,
                                  ref: ref);
                        },
                        child: const Text(
                          "Forgot Pin?",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                  error: (error, stack) => const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink()),

              const Spacer(flex: 4),
              // digits
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        3, (index) => numButton(1 + 3 * i + index)).toList(),
                  ),
                ),
              // digits with backspace
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    biometrics && enteredPin.isEmpty
                        ? GestureDetector(
                            onTap: () async {
                              var auth =
                                  await LocalAuthService.authenticateUser();
                              if (auth) {
                                Go.to(const UserScreen());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Authentication failed.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 32),
                              constraints: const BoxConstraints(
                                maxHeight: 64,
                                maxWidth: 64,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDark
                                    ? ZealPalette.lighterBlack
                                    : Colors.white,
                              ),
                              child: const ShadImage(
                                ZeelSvg.fingerprint,
                                height: 30.0,
                                width: 30.0,
                              ),
                            ),
                          )
                        : const TextButton(
                            onPressed: null,
                            child: SizedBox(),
                          ),
                    numButton(0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (enteredPin.isNotEmpty) {
                            enteredPin =
                                enteredPin.substring(0, enteredPin.length - 1);
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 32),
                        constraints: const BoxConstraints(
                          maxHeight: 64,
                          maxWidth: 64,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              isDark ? ZealPalette.lighterBlack : Colors.white,
                        ),
                        child: Icon(
                          Icons.keyboard_backspace_rounded,
                          color: isDark ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
