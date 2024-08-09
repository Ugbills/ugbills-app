import 'package:flutter/material.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/pay/tv/tv_transaction_details.dart';
import 'package:zeelpay/screens/widgets/sent.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class TVBills extends StatelessWidget {
  const TVBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV'),
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
              const ZeelSelectTextField(hint: "DSTV"),
              const SizedBox(
                height: 5,
              ),
              const ZeelTextFieldTitle(text: "Package"),
              const ZeelSelectTextField(hint: "DSTV Premium"),
              const SizedBox(
                height: 5,
              ),
              const ZeelTextFieldTitle(text: "Smartcard Number"),
              const ZeelTextField(
                  hint: "Enter your smartcard number", enabled: true),
              const SizedBox(
                height: 5,
              ),
              const ZeelTextFieldTitle(text: "Amount"),
              const ZeelTextField(hint: "NGN1000", enabled: false),
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
                                "Your DSTV Premium payment of ₦12,000.00 has been processed successfully.",
                            nextPage: TvTransactionDetails(
                              tvLogo: ZeelPng.dstv,
                              amount: "12,000",
                              transactionID: "2D94ty823",
                              dateAndTime: "Mar 10 2023, 2:33PM",
                              smartcardNumber: "08000000000",
                              serviceProvider: "DSTV",
                              plan: "DSTV Premium",
                              fee: "10.00",
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
