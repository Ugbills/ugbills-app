import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/providers/card_provider.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class DollarCardTransactionHistory extends ConsumerWidget {
  final String cardId;
  const DollarCardTransactionHistory({super.key, required this.cardId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var history = ref.watch(getCardTransactionsProvider(cardId: cardId));
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Transaction History",
            style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
        forceMaterialTransparency: true,
      ),
      body: history.when(
          error: (error, stack) => Text('Error: $error'),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (transaction) => transaction!.data!.isEmpty
              ? const Center(
                  child: Text("No transaction"),
                )
              : Container(
                  constraints:
                      const BoxConstraints(maxHeight: double.maxFinite),
                  margin: const EdgeInsets.symmetric(horizontal: 24)
                      .copyWith(top: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isDark ? ZealPalette.lighterBlack : Colors.white,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: transaction.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.asset(ZeelPng.amazon),
                          title: Text(transaction.data![index].receipient!),
                          subtitle: Text(
                            transaction.data![index].createdAt!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10),
                          ),
                          trailing: Text(
                            "\$${transaction.data![index].amount!}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: transaction.data![index].transactionType!
                                          .toLowerCase() ==
                                      "credit"
                                  ? ZealPalette.successGreen
                                  : ZealPalette.rustColor,
                            ),
                          ),
                        );
                      }),
                )),
    );
  }
}
