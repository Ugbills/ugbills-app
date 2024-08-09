import 'package:flutter/material.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/trade/crypto_transaction_details.dart';
import 'package:zeelpay/screens/widgets/sent.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ConfirmBuyDetails extends StatelessWidget {
  final String title, network;
  const ConfirmBuyDetails({
    super.key,
    required this.title,
    required this.network,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        title: Text(
          'Buy $title',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: ZeelBackButton(
          color: isDark ? ZealPalette.lighterBlack : Colors.white,
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
                        _detail("USD Amount", "₦15,000"),
                        _detail("Token Amount", "10 USDT"),
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
                                color: ZealPalette.rustColor.withAlpha(20),
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
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? ZealPalette.lighterBlack : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$network Address",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const Text(
                          "0x000000000000000000000000000000000000dEaD",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12),
                        ),
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
                      builder: (_) => SentSuccessfully(
                        title: "Done",
                        body:
                            "You have successfully purchased \$20 USDT. The coins have been sent to your wallet address 0XXXX.",
                        nextPage: CryptoTransactionDetails(
                            cryptoCoinLogo: ZeelPng.tether,
                            amount: "₦15,000.00",
                            transactionID: "#2D94ty823",
                            dateAndTime: "Mar 10 2023, 2:33PM",
                            usdAmount: "\$10",
                            tokenAmount: "10 USDT",
                            token: network,
                            type: "Buy Crypto",
                            usdtAddress: "0x93490355344433443",
                            fee: "₦10.00"),
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
