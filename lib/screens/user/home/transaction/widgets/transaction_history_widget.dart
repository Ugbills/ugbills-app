import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/controllers/bills/data_controller.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/providers/transaction_provider.dart';
import 'package:ugbills/screens/user/home/transaction/details.dart';
import 'package:ugbills/themes/palette.dart';

class TransactionHistoryWidget extends ConsumerWidget {
  final int? limit;
  const TransactionHistoryWidget({this.limit = 100, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var transactions =
        ref.watch(fetchUserTransactionsProvider(limit: limit!, page: 1));

    return transactions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
        data: (activity) => (activity!.isEmpty)
            ? const Center(
                child: Text(
                  "No activity Yet!",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activity.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    InkWell(
                      onTap: () {
                        Go.to(TransactionDetails(
                          transaction: activity[index],
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ShadImage(
                                activity[index].method == "electricity"
                                    ? ZeelSvg.electricity
                                    : activity[index].method == "cabletv"
                                        ? ZeelSvg.cable
                                        : activity[index].method == "betting"
                                            ? ZeelSvg.bet
                                            : (activity[index].method ==
                                                        "data" ||
                                                    activity[index].method ==
                                                        "airtime")
                                                ? getNetWorkIcon(activity[index]
                                                        .billProvider!)
                                                    .toString()
                                                : activity[index].method ==
                                                            "buy_crypto" ||
                                                        activity[index].method ==
                                                            "sell_crypto"
                                                    ? getCryptoIcon(
                                                            activity[index]
                                                                .billProvider!)
                                                        .toString()
                                                    : activity[index].method ==
                                                            "coupon"
                                                        ? ZeelSvg.coupon
                                                        : activity[index]
                                                                    .method ==
                                                                "transfer"
                                                            ? ZeelSvg.money
                                                            : activity[index]
                                                                        .method ==
                                                                    "virtual_card"
                                                                ? ZeelSvg.vc
                                                                : activity[index]
                                                                            .method ==
                                                                        "reward"
                                                                    ? ZeelSvg
                                                                        .reward
                                                                    : ZeelSvg
                                                                        .money,
                                height: 40,
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity[index]
                                        .method!
                                        .toUpperCase()
                                        .replaceAll("_", " "),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    formartDate(activity[index].createdAt!),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "NGN${activity[index].amount}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: activity[index].status!.toLowerCase() ==
                                      "success"
                                  ? ZealPalette.successGreen
                                  : ZealPalette.errorRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ]);
                }));
  }
}
