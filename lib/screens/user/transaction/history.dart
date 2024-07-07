import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: const Text("Transaction History"),
        leading: const ZeelBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(
              height: 64,
              child: ShadInput(
                decoration: ShadDecoration(
                    color: Colors.white,
                    focusedBorder: ShadBorder.none,
                    border: ShadBorder(
                      radius: BorderRadiusGeometry.lerp(
                        BorderRadius.circular(20),
                        BorderRadius.circular(20),
                        1,
                      ),
                    )),
                placeholder: Text(
                  "Search for transaction",
                  style: ShadTheme.of(context)
                      .textTheme
                      .large
                      .copyWith(color: Colors.grey),
                ),
                suffix: const ShadImage(
                  ZeelSvg.search,
                  height: 24,
                  width: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
