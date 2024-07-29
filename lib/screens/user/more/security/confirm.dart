import 'package:flutter/material.dart';
import 'package:zeelpay/screens/user/more/success.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ConfirmTransactionPin extends StatefulWidget {
  const ConfirmTransactionPin({super.key});

  @override
  State<ConfirmTransactionPin> createState() => _ConfirmTransactionPinState();
}

class _ConfirmTransactionPinState extends State<ConfirmTransactionPin> {
  String enteredPin = '';
  bool pinProgress = false;

  void onPinComplete() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Success(
          title: "Updated",
          body:
              "Your password has been updated successfully and should be used on next login.",
        ),
      ),
    );
  }

  Widget numButton(int number) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: TextButton(
          onPressed: () {
            setState(() {
              if (enteredPin.length < 4) {
                enteredPin += number.toString();
                if (enteredPin.length == 4) {
                  onPinComplete();
                }
              }
            });
          },
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const ZeelTitleText(text: "Confirm New Pin"),
            const Text("Re-enter new 4-digit transaction pin."),
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
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
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
                  children:
                      List.generate(3, (index) => numButton(1 + 3 * i + index))
                          .toList(),
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
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (enteredPin.isNotEmpty) {
                          enteredPin =
                              enteredPin.substring(0, enteredPin.length - 1);
                        }
                      });
                    },
                    child: const Icon(
                      Icons.keyboard_backspace_rounded,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class UpdatedSuccessfully extends StatelessWidget {
  const UpdatedSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Image.asset("assets/images/sent.png"),
            const ZeelTitleText(text: "Updated"),
            const Text(
              "Your password has been updated successfully and should be used on next login.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            ZeelButton(
              text: "Back",
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const UserScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
