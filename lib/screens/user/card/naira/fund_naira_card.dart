import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/screens/user/card/success_message.dart';
import 'package:ugbills/screens/widgets/number_pad.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class FundNairaCard extends ConsumerWidget {
  const FundNairaCard({super.key});

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
          'Fund Card',
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
                    "₦ $amount",
                    style: theme.textTheme.h2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Number Pad Section Starts Here
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            // NUMBER PAD
            ZeelNumberPad(
              provider: amountProvider,
              ref: ref,
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ZeelAltButton(
                      onPressed: amount == "0.00"
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) {
                                        return const SuccessMessage(
                                          title: "Card Funded",
                                          body:
                                              "You have successfully added ₦20,000 to your dollar card.",
                                        );
                                      },
                                      settings:
                                          RouteSettings(arguments: amount)));
                            },
                      text: "Fund",
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
