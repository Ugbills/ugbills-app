import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/card/modal.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CreateCardScreen extends StatelessWidget {
  const CreateCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              ShadImage(
                ZeelPng.card,
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20.0),
              Text(
                "Make Payments Anywhere Online",
                style: ShadTheme.of(context)
                    .textTheme
                    .h1
                    .copyWith(color: ShadTheme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              const Text(
                "A virtual card that makes life easier, pay for anything online with your card",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ZeelButton(
                    text: "Create",
                    onPressed: () {
                      CardModal.showModal(context);
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
