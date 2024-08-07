import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/pay/airtime/airtime_transaction_details.dart';
import 'package:zeelpay/screens/user/trade/sent.dart';
import 'package:zeelpay/screens/user/widgets/widgets.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class AirtimeBills extends StatelessWidget {
  const AirtimeBills({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = ShadTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Airtime'),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZeelNetwork(
                    icon: ZeelPng.mtn,
                  ),
                  ZeelNetwork(
                    icon: ZeelPng.airtel,
                  ),
                  ZeelNetwork(
                    icon: ZeelPng.glo,
                  ),
                  ZeelNetwork(
                    icon: ZeelPng.mobile,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const ZeelTextFieldTitle(text: "Amount to buy"),
              const ZeelTextField(hint: "NGN1000", enabled: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZeelQuickAmount(
                    theme: theme,
                    text: "₦100",
                  ),
                  ZeelQuickAmount(
                    theme: theme,
                    text: "₦200",
                  ),
                  ZeelQuickAmount(
                    theme: theme,
                    text: "₦500",
                  ),
                  ZeelQuickAmount(
                    theme: theme,
                    text: "₦1000",
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Balance: "),
                  Text(
                    "₦0.00",
                    style: theme.textTheme.small,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const ZeelTextFieldTitle(text: "Phone Number"),
              const ZeelTextField(hint: "0800 000 0000", enabled: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose Contact",
                    style: theme.textTheme.small,
                  )
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ZeelButton(
                    text: "Buy",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SentSuccessfully(
                            title: "Completed",
                            body:
                                "Your airtime purchase of ₦200 for 08000000000 on the MTN network was successful.",
                            nextPage: AirtimeTransactionDetails(
                              networkLogo: ZeelPng.mtn_2,
                              amount: '1,000',
                              transactionID: '2D94ty823',
                              dateAndTime: 'Mar 10 2023, 2:33PM',
                              phoneNumber: '08000000000',
                              serviceProvider: 'MTN',
                              fee: '10.00',
                              note: 'None',
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
