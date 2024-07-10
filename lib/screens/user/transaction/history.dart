import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: const Text("Transaction History"),
        leading: const ZeelBackButton(),
      ),
      body: const Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            ZeelTextField(hint: "Search for a transaction", enabled: true)
          ],
        ),
      ),
    );
  }
}
