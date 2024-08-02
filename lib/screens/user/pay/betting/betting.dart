import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/pay/betting/betting_transaction_details.dart';
import 'package:zeelpay/screens/user/trade/sent.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class BettingBills extends StatelessWidget {
  const BettingBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Betting'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: ZeelScrollable(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ZeelTextFieldTitle(text: "Select Provider"),
              const ZeelSelectTextField(hint: "SportyBet"),
              const SizedBox(
                height: 5,
              ),
              const ZeelTextFieldTitle(text: "User ID"),
              const ZeelTextField(
                  hint: "Enter your sportybet phone number", enabled: true),
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
                          builder: (context) => const SentSuccessfully(
                            title: "Completed",
                            body:
                                "Your Sportybet payment of ₦7,000.00 has been processed successfully.",
                            nextPage: BettingTransactionDetails(
                              bettingLogo: ZeelPng.sporty,
                              amount: " ₦7,000",
                              transactionID: "#2D94ty823",
                              dateAndTime: "Mar 10 2023, 2:33PM",
                              userID: "2304834",
                              serviceProvider: "Sportybet",
                              fee: "₦10.00",
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
        ),
      )),
    );
  }
}
