import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CouponCompleted extends StatelessWidget {
  final String message;
  const CouponCompleted({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var theme = ShadTheme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ShadImage.square(ZeelPng.success, size: 218),
              const SizedBox(
                height: 30,
              ),
              Text("Completed",
                  style: theme.textTheme.h2.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.p,
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: ZeelButton(
                  text: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
