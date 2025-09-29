import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/providers/transaction_provider.dart';
import 'package:ugbills/screens/user/home/transaction/details.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class TransactionHistory extends ConsumerWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var transactions =
        ref.watch(fetchUserTransactionsProvider(limit: 100, page: 1));

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 100,
        title: const Text("Transaction History"),
        leading: const ZeelBackButton(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(fetchUserTransactionsProvider(limit: 100, page: 1));
        },
        child: transactions.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (activity) => (activity!.isEmpty)
              ? const Center(
                  child: Text(
                    "No activity Yet!",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : GroupedListView<dynamic, String>(
                  elements: activity,
                  groupBy: (element) {
                    final dateStr = element.createdAt ?? "";
                    if (dateStr.isEmpty) return "1970-01-01";
                    try {
                      final date = DateTime.parse(dateStr);
                      return "${date.year}-${date.month.toString().padLeft(2, '0')}-01";
                    } catch (e) {
                      return "1970-01-01";
                    }
                  },
                  groupSeparatorBuilder: (String groupByValue) {
                    final date = DateTime.parse(groupByValue);
                    final DateFormat formatter = DateFormat('MMMM yyyy');
                    final formattedDate = formatter.format(date);
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: MediaQuery.of(context).size.width / 1.5,
                          top: 10,
                          bottom: 10),
                      child: TransactionHeader(
                          date: formattedDate, isDark: isDark),
                    );
                  },
                  itemBuilder: (context, element) {
                    return GestureDetector(
                      onTap: () {
                        Go.to(TransactionDetails(
                          transaction: element,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? ZealPalette.lighterBlack
                                : Colors.white,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: const ShadImage<String>(
                                        ZeelSvg.money,
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (element.operation ?? "N/A")
                                            .toUpperCase()
                                            .replaceAll("_", " "),
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        formartDate(element.createdAt ?? ""),
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
                                "₦${returnAmount(element.amount)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemComparator: (item1, item2) {
                    final date1 = item1.createdAt ?? "";
                    final date2 = item2.createdAt ?? "";
                    return date1.compareTo(date2);
                  },
                  order: GroupedListOrder.DESC,
                ),
        ),
      ),
    );
  }
}

class TransactionHeader extends StatelessWidget {
  final String date;
  final bool isDark;
  const TransactionHeader({
    super.key,
    required this.date,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isDark ? Colors.grey.shade700 : Colors.grey.shade500,
      ),
      child: Text(
        date,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.grey.shade400 : Colors.grey.shade200,
        ),
      ),
    );
  }
}
