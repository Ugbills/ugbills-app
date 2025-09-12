import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/controllers/bills/giftcard_controller.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class ConfirmGiftcardDetails extends ConsumerWidget {
  final String title,
      iconUrl,
      countryCode,
      productName,
      productId,
      brandId,
      usdAmount,
      nairaAmount,
      dateAndTime,
      fee;
  final dynamic unitPrice;
  const ConfirmGiftcardDetails({
    super.key,
    this.title = 'Netflix',
    required this.iconUrl,
    required this.productName,
    required this.unitPrice,
    required this.brandId,
    required this.countryCode,
    required this.productId,
    required this.usdAmount,
    required this.nairaAmount,
    required this.dateAndTime,
    required this.fee,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var isloading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        _detail("USD Amount", "\$$usdAmount"),
                        _detail("Naira Amount", nairaAmount),
                        _detail("Date & Time", dateAndTime),
                        _detail("Fees", fee),
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
              isLoading: isloading,
              onPressed: () {
                Go.to(ConfirmTransaction(
                  onPinComplete: (pin) async {
                    await buyGiftCard(
                        context: context,
                        productId: productId,
                        productName: productName,
                        brandId: brandId,
                        countryCode: countryCode,
                        quantity: 1,
                        pin: pin!,
                        ref: ref,
                        iconUrl: iconUrl,
                        unitPrice: unitPrice);
                  },
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
