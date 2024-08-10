import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/pay/swap/swap_transaction_details.dart';
import 'package:zeelpay/screens/widgets/sent.dart';
import 'package:zeelpay/screens/user/widgets/widgets.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class AirtimeSwap extends StatelessWidget {
  const AirtimeSwap({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = ShadTheme.of(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airtime to Cash'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          // crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 24),
            const ZeelTextFieldTitle(text: "Share N Sell PIN"),
            const ZeelTextField(enabled: true, hint: "0000"),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark
                    ? ZealPalette.orange
                    : ZealPalette.rustColor.withAlpha(20),
                border: Border.all(color: ZealPalette.rustColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Note",
                    style: TextStyle(
                      color: ZealPalette.rustColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Share n Sell pin allows you transfer airtime from one MTN user to another.",
                    style: TextStyle(
                      color: isDark ? ZealPalette.rustColor : Colors.grey,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 45),
            ZeelButton(
              text: "Swap",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SentSuccessfully(
                      title: "Airtime Converted",
                      body:
                          "Your Airtime of ₦7,000.00 has been  successfully converted to cash.",
                      nextPage: SwapTransactionDetails(
                        networkLogo: ZeelPng.mtn_2,
                        amount: '1,000',
                        transactionID: '2D94ty823',
                        dateAndTime: 'Mar 10 2023, 2:33PM',
                        phoneNumber: '08000000000',
                        serviceProvider: 'MTN',
                        product: 'Airtime to Cash',
                        fee: '10.00',
                        note: 'None',
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
