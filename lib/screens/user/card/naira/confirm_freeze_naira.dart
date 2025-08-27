import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ConfirmFreezeNairaCard extends StatefulWidget {
  const ConfirmFreezeNairaCard({super.key});

  @override
  State<ConfirmFreezeNairaCard> createState() => _ConfirmFreezeNairaCardState();
}

class _ConfirmFreezeNairaCardState extends State<ConfirmFreezeNairaCard> {
  String enteredPin = '';
  bool pinProgress = false;

  void onPinComplete() {
    Navigator.pop(context);
  }

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
                  onPinComplete();
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const ZeelTitleText(text: "Confirm Freeze"),
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
                        color: isDark ? ZealPalette.lighterBlack : Colors.white,
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
    );
  }
}
