import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/widgets/zeel_tile.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trade Crypto',
          style: ShadTheme.of(context).textTheme.h3,
        ),
        leading: const SizedBox.shrink(),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              ZeelTile(
                leadingImage: ZeelPng.buyCrypto,
                title: 'Buy Crypto',
                subtitle: 'Buy BTC, ETH, LTC and lot more for quick cash.',
              ),
              ZeelTile(
                leadingImage: ZeelPng.sellCrypto,
                title: 'Sell Crypto',
                subtitle: 'Sell BTC, ETH, LTC and lot more for quick cash.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
