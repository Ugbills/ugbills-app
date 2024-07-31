import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/trade/sell/bitcoin/bitcoin.dart';
import 'package:zeelpay/screens/user/trade/sell/ethereum/ethereum.dart';
import 'package:zeelpay/screens/user/trade/sell/tether/tether.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class SellCryptoOptions extends StatelessWidget {
  const SellCryptoOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final List buyOptions = [
      [ZeelPng.tether, "Tether", "USDT", const SellTether()],
      [ZeelPng.bitcoin, "Bitcoin", "BTC", const SellBitcoin()],
      [ZeelPng.ethereum, "Ethereum", "ETH", const SellEthereum()],
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
                color: Colors.white,
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
