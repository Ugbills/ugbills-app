import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class NairaCardTransactionHistory extends StatelessWidget {
  const NairaCardTransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final List history = [
      [ZeelPng.playstore, "Play Store", "06:59 PM • 07 Mar", "\$30", true],
      [ZeelPng.amazon, "Amazon Shopping", "06:59 PM • 07 Mar", "\$202", false],
    ];
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Transaction History",
            style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: Container(
        constraints: const BoxConstraints(maxHeight: double.maxFinite),
        margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isDark ? ZealPalette.lighterBlack : Colors.white,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: history.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset(history[index][0]),
                title: Text(history[index][1]),
                subtitle: Text(
                  history[index][2],
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                trailing: Text(
                  history[index][3],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: history[index][4]
                        ? ZealPalette.successGreen
                        : ZealPalette.rustColor,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
