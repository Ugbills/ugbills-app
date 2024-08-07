import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/trade/buy/options.dart';
import 'package:zeelpay/screens/user/trade/sell/options.dart';
import 'package:zeelpay/screens/user/widgets/zeel_tile.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Trade Crypto',
          style: ShadTheme.of(context).textTheme.h3,
        ),
        leading: const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ZeelTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BuyCryptoOptions(),
                      ));
                },
                leadingImage: ZeelPng.buyCrypto,
                title: 'Buy Crypto',
                subtitle: 'Buy BTC, ETH, LTC and lot more for quick cash.',
              ),
              ZeelTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SellCryptoOptions(),
                      ));
                },
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
