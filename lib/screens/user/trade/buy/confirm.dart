import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/controllers/trade/crypto_controller.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/helpers/common/data_formatter.dart';
import 'package:zeelpay/providers/crypto_provider.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/widgets/authenticate_transaction.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ConfirmBuyDetails extends ConsumerWidget {
  final String title, network, currency, address;
  final double amount;
  const ConfirmBuyDetails({
    super.key,
    required this.title,
    required this.network,
    required this.address,
    required this.currency,
    required this.amount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var buyQuote = ref
        .watch(fetchCryptoBuyQuoteProvider(currency: currency, amount: amount));

    var isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
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
          child: buyQuote.when(
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
                                "\$${returnUsdAmount(data!.data!.usdValue!)}"),
                            _detail("Token Amount",
                                "${data.data!.receive!} ${data.data!.currency!.toUpperCase()}"),
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
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isDark ? ZealPalette.lighterBlack : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$network Address",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              address,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
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
                  isLoading: isLoading,
                  onPressed: () => Go.to(ConfirmTransaction(
                    onPinComplete: (pin) => buyCrypto(
                        context: context,
                        tokenAmount: data.data!.receive!,
                        currency: currency,
                        pin: pin!,
                        ref: ref,
                        amount: amount,
                        network: network,
                        receivingAddress: address),
                  )),
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
