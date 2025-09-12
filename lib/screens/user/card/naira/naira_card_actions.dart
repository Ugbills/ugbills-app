import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/screens/user/card/available.dart';
import 'package:ugbills/screens/user/card/naira/confirm_freeze_naira.dart';
import 'package:ugbills/screens/user/card/naira/fund_naira_card.dart';
import 'package:ugbills/screens/user/card/naira/naira_card_details.dart';
import 'package:ugbills/screens/user/card/naira/naira_card_history.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class NairaVirtualCardActions extends ConsumerWidget {
  final String cardId;
  const NairaVirtualCardActions({super.key, required this.cardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List options = [
      [ZeelSvg.fundCard, "Fund", const FundNairaCard()],
      [ZeelSvg.withdraw, "Withdraw", const AvailableCards()],
      [ZeelSvg.details, "Card Details", const NairaCardDetails()],
      [
        ZeelSvg.transaction,
        "Transactions",
        const NairaCardTransactionHistory()
      ],
      [ZeelSvg.freeze, "Freeze Card", const ConfirmFreezeNairaCard()],
    ];

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Naira Virtual Card",
            style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(20, 20, 20, 1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(ZeelPng.ellipse, height: 152),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(ZeelPng.whitezeel),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8).copyWith(right: 65),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Card Balance",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "₦15,020.00",
                                style: TextStyle(
                                  fontSize: ShadTheme.of(context)
                                      .textTheme
                                      .small
                                      .fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(ZeelPng.mastercard),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ListView.builder(
              itemCount: options.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return buildOptions(
                  options[index][0],
                  options[index][1],
                  options[index][2],
                  context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOptions(
    String leading, String title, Widget route, BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => route));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark ? ZealPalette.lighterBlack : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ShadImage.square(leading, size: 36),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      ),
    ),
  );
}
