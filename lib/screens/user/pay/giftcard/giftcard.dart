import 'package:flutter/material.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/screens/user/pay/giftcard/buy/buy_giftcard.dart';
import 'package:ugbills/screens/user/pay/giftcard/coming.dart';
import 'package:ugbills/screens/user/widgets/zeel_tile.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class GiftcardScreen extends StatelessWidget {
  const GiftcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: const Text(
          'Gift Card',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ZeelTile(
            title: "Buy Gift Card",
            subtitle: "Buy brands and stores gift card for loved ones",
            leadingImage: ZeelPng.giftCard,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BuyGiftcard(),
                  ));
            },
          ),
          const SizedBox(height: 6),
          ZeelTile(
            title: "Sell Gift Card",
            subtitle: "Sell Brands and stores gift card for instant cash",
            leadingImage: ZeelPng.card,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ComingSoon(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
