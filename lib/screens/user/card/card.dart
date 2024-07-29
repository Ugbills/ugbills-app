import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/card/dollar/dollar.dart';
import 'package:zeelpay/screens/user/card/naira/naira.dart';
import 'package:zeelpay/screens/user/widgets/zeel_tile.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      showShadSheet(
                          side: ShadSheetSide.bottom,
                          context: context,
                          builder: (context) => ShadSheet(
                                radius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                removeBorderRadiusWhenTiny: false,
                                title: const Text("Card Type"),
                                content: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50, top: 10),
                                  child: Column(
                                    children: [
                                      ZeelTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const NairaCardScreen(),
                                              ),
                                            );
                                          },
                                          title: "Naira Card",
                                          subtitle:
                                              "Pay for anything with your local currency card",
                                          leadingImage: ZeelPng.buyCrypto),
                                      ZeelTile(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const DollarVirtualcard(),
                                              ),
                                            );
                                          },
                                          title: "Dollar Card",
                                          subtitle:
                                              "Pay for anything globally with your dollar card",
                                          leadingImage: ZeelPng.sellCrypto),
                                    ],
                                  ),
                                ),
                              ));
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
