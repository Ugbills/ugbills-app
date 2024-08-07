import 'package:flutter/material.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/pay/giftcard/giftcard_transaction_details.dart';
import 'package:zeelpay/screens/user/trade/sent.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ConfirmGiftcardDetails extends StatelessWidget {
  final String title, transactionID, usdAmount, nairaAmount, dateAndTime, fee;
  const ConfirmGiftcardDetails({
    super.key,
    this.title = 'Netflix',
    required this.transactionID,
    required this.usdAmount,
    required this.nairaAmount,
    required this.dateAndTime,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        title: Text('Sell $title',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? ZealPalette.lighterBlack : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _detail("Transaction ID", "d230982wj23"),
                        _detail("USD Amount", "\$15"),
                        _detail("Naira Amount", "₦55,000"),
                        _detail("Date & Time", "Mar 09 2024, 5:04PM"),
                        _detail("Fees", "₦150"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Status",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? ZealPalette.orange
                                    : ZealPalette.rustColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Text(
                                "Pending",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: ZealPalette.rustColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
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
                          "Once you hit “Confirm” we will verify and process the gift card before funding your account.",
                          style: TextStyle(
                            color: isDark ? ZealPalette.rustColor : Colors.grey,
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ZeelButton(
              text: "Confirm",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SentSuccessfully(
                        title: "Gift Card is Coming!",
                        body:
                            "Your purchase of the \$20 Netflix gift card was successful. You'll receive an email with the gift card details shortly.",
                        nextPage: GiftcardTransactionDetails(
                          giftcardLogo: ZeelPng.tether,
                          amount: "₦20,000.00",
                          transactionID: "#2D94ty823",
                          dateAndTime: "Mar 10 2023, 2:33PM",
                          usdAmount: "\$10",
                          card: "Netflix",
                          fee: "₦10.00",
                          note: 'None',
                        ),
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget _detail(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ],
    ),
  );
}
