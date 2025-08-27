import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class DollarCardDetails extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String address;
  const DollarCardDetails(
      {super.key,
      required this.cardNumber,
      required this.expiryDate,
      required this.cvv,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Card Details", style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const ZeelTextFieldTitle(text: "Card Number"),
          ZeelTextField(
              controller: TextEditingController(text: cardNumber),
              enabled: false,
              copy: true),
          const ZeelTextFieldTitle(text: "Expiry Date"),
          ZeelTextField(
              enabled: false,
              controller: TextEditingController(text: expiryDate),
              copy: true),
          const ZeelTextFieldTitle(text: "CVV"),
          ZeelTextField(
              controller: TextEditingController(text: cvv),
              enabled: false,
              copy: true),
          const ZeelTextFieldTitle(text: "Address"),
          ZeelTextField(
              controller: TextEditingController(
                  text: address.isEmpty ? "Not set" : address),
              enabled: false,
              copy: true),
        ],
      ),
    );
  }
}
