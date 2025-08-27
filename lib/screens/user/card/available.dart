import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/providers/card_provider.dart';
import 'package:zeelpay/screens/user/card/dollar/dollar_card_actions.dart';
import 'package:zeelpay/screens/user/card/modal.dart';
import 'package:zeelpay/screens/user/card/naira/naira_card_actions.dart';
import 'package:zeelpay/themes/palette.dart';

class AvailableCards extends ConsumerWidget {
  const AvailableCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var cards = ref.watch(getAllCardsProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    CardModal.showModal(context);
                  },
                  style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.transparent,
                      side: BorderSide(
                        color: isDark
                            ? ZealPalette.lightPurple
                            : ZealPalette.primaryPurple,
                      )),
                  child: Text(
                    "Create",
                    style: TextStyle(
                        color:
                            isDark ? Colors.white : ZealPalette.primaryPurple),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              cards.when(
                error: (error, stack) => Text('Error: $error'),
                loading: () => const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
                data: (card) => Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: card!.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 24),
                        itemBuilder: (context, index) => availableCard(
                            card.data![index].cardCurrency!.toUpperCase() ==
                                    "USD"
                                ? ZealPalette.primaryPurple
                                : const Color.fromARGB(20, 20, 20, 1),
                            card.data![index].cardCurrency!,
                            card.data![index].maskedPan!,
                            card.data![index].cardCurrency! == "USD"
                                ? DollarVirtualCardActions(
                                    cardId: card.data![index].cardId!)
                                : NairaVirtualCardActions(
                                    cardId: card.data![index].cardId!),
                            context))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget availableCard(Color color, String currency, String maskedPan,
    Widget route, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => route,
          ));
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(ZeelPng.ellipse, height: 132),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(ZeelPng.whitezeel),
                Text(
                  "$currency Card",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  maskedPan,
                  style: const TextStyle(color: Colors.white),
                ),
                Image.asset(ZeelPng.mastercard),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
