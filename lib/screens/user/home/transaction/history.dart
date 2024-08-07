import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/home/transaction/transaction_history_widget.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    List history = [
      ["February 2024", const TransactionHistoryWidget()],
      ["March 2024", const TransactionHistoryWidget()],
      ["April 2024", const TransactionHistoryWidget()],
      ["May 2024", const TransactionHistoryWidget()],
    ];
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: const Text("Transaction History"),
        leading: const ZeelBackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30.0),
        children: [
          const ZeelTextField(hint: "Search for a transaction", enabled: true),
          ListView.builder(
              itemCount: history.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade500,
                      ),
                      child: Text(
                        history[index][0],
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: isDark ? ZealPalette.lighterBlack : Colors.white,
                      ),
                      child: history[index][1],
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }
}
