import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeelpay/controllers/user/user_controller.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ConfirmTransactionPin extends ConsumerStatefulWidget {
  final String otp;
  final String pin;
  final String email;
  const ConfirmTransactionPin(
      {super.key, required this.otp, required this.pin, required this.email});

  @override
  ConsumerState<ConfirmTransactionPin> createState() =>
      _ConfirmTransactionPinState();
}

class _ConfirmTransactionPinState extends ConsumerState<ConfirmTransactionPin> {
  String enteredPin = '';
  bool pinProgress = false;

  void onPinComplete() {
    //check if pin matches, if it does not clear the entered pin
    if (widget.pin != enteredPin) {
      setState(() {
        errorSnack(context, "Pins do not match. Please try again.");
        enteredPin = '';
      });
    } else {
      ref.read(isLoadingProvider.notifier).state = true;
      ref.read(userControllerProvider.notifier).resetPin(
          ref: ref,
          email: widget.email,
          otp: widget.otp,
          newPin: enteredPin,
          context: context);
    }
  }

  Widget numButton(int number) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (enteredPin.length < 4) {
              enteredPin += number.toString();
              if (enteredPin.length == 4) {
                onPinComplete();
              }
            }
          });
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;

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
        leading: const ZeelBackButton(),
        leadingWidth: 100,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const ZeelTitleText(text: "Create New Pin"),
              const Text("Enter new 4-digit transaction pin."),
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
                          color: isDark
                              ? ZealPalette.lighterBlack
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: index < enteredPin.length
                                ? pinProgress
                                    ? Colors.grey
                                    : Colors.grey
                                : ZealPalette.primaryPurple.withOpacity(0),
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
                    const TextButton(
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
