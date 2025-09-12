import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/helpers/common/icon_helper.dart';
import 'package:ugbills/providers/swap_provider.dart';
import 'package:ugbills/screens/user/pay/swap/swap_transaction_details.dart';
import 'package:ugbills/screens/user/user.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class SwapResult extends ConsumerWidget {
  final String networkId;
  final dynamic amount;
  final String phoneNumber;
  const SwapResult(
      {super.key,
      required this.networkId,
      this.amount,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    var swapResult = ref.watch(swapAirtimeProvider(
        amount: amount, network: networkId, phoneNumber: phoneNumber));
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          leadingWidth: 100,
          forceMaterialTransparency: true,
        ),
        body: swapResult.when(
          data: (swap) => Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Image.asset(ZeelPng.done),
                Text(
                  swap!.data!.status!.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : ZealPalette.primaryBlue,
                  ),
                ),
                const Text(
                  "You have successfully swapped airtime to cash",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                ZeelButton(
                  // color: Colors.transparent,
                  // borderColor: true,
                  text: "View Transaction",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SwapTransactionDetails(
                          networkLogo: getNetWorkIcon(
                              swap.data!.serviceProvider!.toLowerCase()),
                          amount: returnAmount(swap.data!.amount!),
                          transactionID: swap.data!.reference!,
                          dateAndTime: formartDate(swap.data!.date!),
                          phoneNumber: swap.data!.phoneNumber!,
                          serviceProvider: swap.data!.serviceProvider!,
                          product: swap.data!.product!,
                          fee: returnAmount(swap.data!.fee!),
                          note: swap.message!,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ZeelButton(
                  text: "Done",
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const UserScreen()));
                  },
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
        ));
  }
}
