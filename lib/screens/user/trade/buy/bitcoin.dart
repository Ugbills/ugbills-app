import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class BuyBitcoin extends StatelessWidget {
  const BuyBitcoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
      ),
      body: ListView(),
    );
  }
}
