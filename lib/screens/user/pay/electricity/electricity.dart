import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/pay/electricity/electricity_transaction_details.dart';
import 'package:zeelpay/screens/user/trade/sent.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class ElectricityBills extends StatelessWidget {
  const ElectricityBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Electricity'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: ZeelScrollable(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ZeelTextFieldTitle(text: "Select Provider"),
            const ZeelSelectTextField(hint: "BEDC"),
            const SizedBox(
              height: 5,
            ),
            const ZeelTextFieldTitle(text: "Type"),
            const ZeelSelectTextField(hint: "Prepaid"),
            const SizedBox(
              height: 5,
            ),
            const ZeelTextFieldTitle(text: "Meter Number"),
            const ZeelTextField(hint: "Enter your meter number", enabled: true),
            const SizedBox(
              height: 5,
            ),
            const ZeelTextFieldTitle(text: "Amount"),
            const ZeelTextField(hint: "NGN1000", enabled: true),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ZeelButton(
                  text: "Confirm",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SentSuccessfully(
                          title: "Completed",
                          body:
                              "Your Kaduna Electricity payment of ₦3,000.00 has been processed successfully.",
                          nextPage: ElectricityTransactionDetails(
                            electricityProviderLogo: ZeelPng.kadunaElectricity,
                            amount: '3,000',
                            transactionID: '2D94ty823',
                            dateAndTime: 'Mar 10 2023, 2:33PM',
                            meterNumber: '08000000000',
                            serviceProvider: 'Kaduna Electricity',
                            type: 'Prepaid',
                            pin: '0000 0000 0000 000 0000',
                            fee: '10.00',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
