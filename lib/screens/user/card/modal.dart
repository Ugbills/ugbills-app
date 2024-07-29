import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/card/dollar/actions.dart';
import 'package:zeelpay/screens/user/card/create/type.dart';
import 'package:zeelpay/screens/user/widgets/zeel_tile.dart';

class CardModal {
  static void showModal(BuildContext context) {
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
                padding: const EdgeInsets.only(bottom: 50, top: 10),
                child: Column(
                  children: [
                    ZeelTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CardType(),
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
                              builder: (context) => const CardType(),
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
  }
}
