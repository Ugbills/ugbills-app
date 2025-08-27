import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/assets/svg.dart';
import 'package:zeelpay/controllers/card/card_controller.dart';
import 'package:zeelpay/screens/widgets/authenticate_transaction.dart';
import 'package:zeelpay/screens/widgets/number_pad.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class WithdrawDollar extends ConsumerWidget {
  final String cardId;
  const WithdrawDollar({super.key, required this.cardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var theme = ShadTheme.of(context);
    var amount = ref.watch(amountProvider);
    return Scaffold(
      backgroundColor:
          isDark ? ZealPalette.scaffoldBlack : theme.colorScheme.primary,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Withdraw',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: ZeelBackButton(
          color: isDark ? ZealPalette.lighterBlack : Colors.white,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ShadImage(ZeelSvg.tag),
          )
        ],
        backgroundColor:
            isDark ? ZealPalette.scaffoldBlack : theme.colorScheme.primary,
        leadingWidth: 100,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amount",
                    style: theme.textTheme.small.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "\$$amount",
                    style: theme.textTheme.h2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // NUMBER PAD
            ZeelNumberPad(
              provider: amountProvider,
              ref: ref,
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ZeelAltButton(
                      onPressed: amount == "0.00"
                          ? null
                          : () {
                              Go.to(ConfirmTransaction(
                                onPinComplete: (pin) async => withdrawCard(
                                    cardId: cardId,
                                    amount: double.parse(amount),
                                    context: context,
                                    pin: pin!,
                                    ref: ref),
                              ));
                            },
                      text: "Withdraw",
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final amountProvider = StateProvider.autoDispose<String>((ref) {
  return "0.00";
});
