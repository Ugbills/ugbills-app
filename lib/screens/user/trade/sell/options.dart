import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/trade/sell/sell_crypto.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class SellCryptoOptions extends StatelessWidget {
  const SellCryptoOptions({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final List buyOptions = [
      [
        ZeelPng.tether,
        "Tether",
        "USDT",
        const SellCrypto(
          cryptoCoin: 'Tether',
          network: 'USDT',
        )
      ],
      [
        ZeelPng.bitcoin,
        "Bitcoin",
        "BTC",
        const SellCrypto(cryptoCoin: "Bitcoin", network: "BTC")
      ],
      [
        ZeelPng.ethereum,
        "Ethereum",
        "ETH",
        const SellCrypto(cryptoCoin: "Ethereum", network: "ETH")
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Crypto',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: buyOptions.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark ? ZealPalette.lighterBlack : Colors.white,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => buyOptions[index][3]),
                  );
                },
                leading: Image.asset(buyOptions[index][0]),
                title: Text(buyOptions[index][1]),
                subtitle: Text(buyOptions[index][2]),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            );
          }),
    );
  }
}
