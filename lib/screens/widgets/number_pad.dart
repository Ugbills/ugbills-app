import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/assets/svg.dart';

class ZeelNumberPad extends StatelessWidget {
  final WidgetRef ref;
  final AutoDisposeStateProvider<String> provider;
  const ZeelNumberPad({
    super.key,
    required this.ref,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _calcButton('1', ref, context, provider),
              _calcButton('2', ref, context, provider),
              _calcButton('3', ref, context, provider),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _calcButton('4', ref, context, provider),
              _calcButton('5', ref, context, provider),
              _calcButton('6', ref, context, provider),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _calcButton('7', ref, context, provider),
              _calcButton('8', ref, context, provider),
              _calcButton('9', ref, context, provider),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _calcButton('.', ref, context, provider),
              _calcButton('0', ref, context, provider),
              GestureDetector(
                  onTap: () {
                    deleteFunc(context, ref, provider);
                  },
                  child: const SizedBox(
                    height: 20,
                    width: 50,
                    child: ShadImage.square(
                      ZeelSvg.delete,
                      size: 20,
                      fit: BoxFit.contain,
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Widget _calcButton(String value, WidgetRef ref, BuildContext context,
    AutoDisposeStateProvider<String> amountProvider) {
  return InkWell(
      borderRadius: BorderRadius.circular(45),
      onTap: () {
        final unformattedCurrentValue =
            ref.read(amountProvider).replaceAll(',', '');

        String newValue;

        if (unformattedCurrentValue == "0.00" && value.trim() != ".") {
          newValue = value.trim();
        } else {
          if (value.trim() == ".") {
            if (!unformattedCurrentValue.contains(".")) {
              newValue = "$unformattedCurrentValue.";
            } else {
              newValue = unformattedCurrentValue;
            }
          } else {
            if (unformattedCurrentValue.contains(".")) {
              final parts = unformattedCurrentValue.split('.');
              final integerPart = parts[0];
              final decimalPart = parts[1];

              if (decimalPart.length < 2) {
                newValue = "$integerPart.${decimalPart + value.trim()}";
              } else {
                newValue = unformattedCurrentValue;
              }
            } else {
              newValue = unformattedCurrentValue + value.trim();
            }
          }
        }

// Check if the new value is within the acceptable range
        double numericValue;
        if (newValue.contains(".")) {
          numericValue = double.parse(newValue);
        } else {
          numericValue = double.parse("$newValue.0");
        }

        if (numericValue > 2000000.00) {
          // If the new value is out of range, don't update it
          ref.read(amountProvider.notifier).state =
              formatMoney(unformattedCurrentValue);
        } else {
          ref.read(amountProvider.notifier).state = formatMoney(newValue);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        child: Text(
          value,
          style: ShadTheme.of(context).textTheme.h3.copyWith(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ));
}

String formatMoney(String value) {
  final parts = value.split('.');
  final integerPart = parts[0];
  final decimalPart = parts.length > 1 ? parts[1] : null;

  // Using Dart's NumberFormat class to format the integer part with commas
  final formattedInteger =
      NumberFormat("#,##0", "en_US").format(int.parse(integerPart));

  if (decimalPart != null) {
    return "$formattedInteger.$decimalPart";
  } else {
    return formattedInteger;
  }
}

void deleteFunc(BuildContext context, WidgetRef ref,
    AutoDisposeStateProvider<String> amountProvider) {
  if (ref.read(amountProvider) == "0.00") {
    return; // Don't do anything if the current value is already 0.00
  }
  final currentValue = ref.read(amountProvider).replaceAll(',', '');

  String newValue;

  if (currentValue.length > 1) {
    newValue = currentValue.substring(0, currentValue.length - 1);
    // If the last character was a comma, remove one more character
    if (currentValue.endsWith(',')) {
      newValue = newValue.substring(0, newValue.length - 1);
    }
  } else {
    newValue = "0.00"; // Reset to default value if we delete everything
  }

  ref.read(amountProvider.notifier).state =
      formatMoney(newValue); // formatMoney is the function we wrote previously
}
