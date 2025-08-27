import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/controllers/trade/crypto_controller.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/helpers/common/data_formatter.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';
import 'package:zeelpay/providers/crypto_provider.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/widgets/authenticate_transaction.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ConfirmSellDetails extends ConsumerWidget {
  final String title, network, currency, coin;
  final double amount;
  const ConfirmSellDetails({
    super.key,
    required this.title,
    required this.coin,
    required this.amount,
    required this.currency,
    required this.network,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var sellQuote = ref.watch(fetchCryptoSellQuoteProvider(
        currency: currency, amount: amount, network: network));
    var isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          leadingWidth: 100,
          title: Text('Sell $title',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          leading: ZeelBackButton(
            color: isDark ? ZealPalette.lighterBlack : Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: sellQuote.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text("Error: $error"),
            ),
            data: (data) => Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isDark ? ZealPalette.lighterBlack : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _detail("USD Amount",
                                "\$${returnUsdAmount(data!.data!.amount!)}"),
                            _detail("Naira Amount",
                                "₦${returnAmount(data.data!.receive)}"),
                            // _detail("Token Amount",
                            //     "${data.data!.pay!} ${data.data!.currency!.toUpperCase()}"),
                            _detail("Date & Time",
                                formartDateTime(DateTime.now().toString())),
                            _detail(
                                "Fees", "₦${returnAmount(data.data!.fee!)}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Status",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
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
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                                  ClipboardData(text: data.data!.address!))
                              .then((_) {
                            successSnack(
                              // ignore: use_build_context_synchronously
                              context,
                              "Wallet address copied to clipboard",
                            );
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? ZealPalette.lighterBlack
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${currency.toUpperCase()} (${network.toUpperCase()}) Address",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                data.data!.address!,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                              "Please send only ${currency.toUpperCase()} (${network.toUpperCase()}) to the above generated Wallet address.",
                              style: TextStyle(
                                  color: isDark
                                      ? ZealPalette.rustColor
                                      : Colors.grey,
                                  fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ZeelButton(
                  text: "Confirm",
                  isLoading: isLoading,
                  onPressed: () => Go.to(ConfirmTransaction(
                      onPinComplete: (pin) => sellCrypto(
                          tokenAmount: data.data!.amount,
                          context: context,
                          currency: currency,
                          ref: ref,
                          network: network,
                          volume: amount))),
                )
              ],
            ),
          ),
        ));
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
