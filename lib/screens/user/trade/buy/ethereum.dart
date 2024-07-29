import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class BuyEthereum extends StatelessWidget {
  const BuyEthereum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Ethereum',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
      ),
    );
  }
}
