import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/controllers/card/card_controller.dart';
import 'package:ugbills/providers/card_provider.dart';
import 'package:ugbills/screens/user/card/dollar/dollar_card_details.dart';
import 'package:ugbills/screens/user/card/dollar/dollar_card_history.dart';
import 'package:ugbills/screens/user/card/dollar/fund_dollar_card.dart';
import 'package:ugbills/screens/user/card/dollar/withdraw_dollar.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class DollarVirtualCardActions extends ConsumerWidget {
  final String cardId;
  const DollarVirtualCardActions({super.key, required this.cardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var card = ref.watch(getCardProvider(cardId: cardId));

    var isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 100,
        title: Text("Dollar Virtual Card",
            style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: card.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => const SizedBox(),
            data: (data) => SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Opacity(
                    opacity: data!.data!.isUsable! ? 1.0 : 0.4,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: ZealPalette.primaryBlue,
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
                                  padding: const EdgeInsets.all(8)
                                      .copyWith(right: 65),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Card Balance",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "\$${data.data!.cardBalance}",
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
                  ),
                  const SizedBox(height: 24),
                  CardTiles(
                    isDark: isDark,
                    leading: ZeelSvg.fundCard,
                    title: "Fund",
                    route: FundDollarCard(
                      cardId: data.data!.cardId!,
                    ),
                  ),
                  CardTiles(
                    isDark: isDark,
                    leading: ZeelSvg.withdraw,
                    title: "Withdraw",
                    route: WithdrawDollar(
                      cardId: data.data!.cardId!,
                    ),
                  ),
                  CardTiles(
                    isDark: isDark,
                    leading: ZeelSvg.details,
                    title: "Card Details",
                    route: DollarCardDetails(
                      expiryDate: data.data!.cardExpiry!,
                      cardNumber: data.data!.cardNumber!,
                      cvv: data.data!.cardCvv!,
                      address:
                          "${data.data!.cardStreet!}, ${data.data!.cardState!}, ${data.data!.cardCity!}, ${data.data!.cardCountry!}, ${data.data!.cardPostalCode!}",
                    ),
                  ),
                  CardTiles(
                    isDark: isDark,
                    leading: ZeelSvg.transaction,
                    title: "Transactions",
                    route: DollarCardTransactionHistory(
                      cardId: data.data!.cardId!,
                    ),
                  ),
                  CardTiles(
                    isDark: isDark,
                    leading: ZeelSvg.freeze,
                    title:
                        data.data!.isUsable! ? "Freeze Card" : "Unfreeze Card",
                    route: ConfirmTransaction(
                      onPinComplete: (pin) {
                        if (data.data!.isUsable!) {
                          freezeCard(
                              context: context,
                              pin: pin!,
                              cardId: cardId,
                              ref: ref);
                        } else {
                          unfreezeCard(
                              context: context,
                              pin: pin!,
                              cardId: cardId,
                              ref: ref);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardTiles extends StatelessWidget {
  final String leading;
  final String title;
  final Widget route;
  const CardTiles({
    super.key,
    required this.isDark,
    required this.leading,
    required this.title,
    required this.route,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
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
}
