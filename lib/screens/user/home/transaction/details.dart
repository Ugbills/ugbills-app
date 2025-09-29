import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/controllers/bills/data_controller.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/helpers/common/transaction_helper.dart';
import 'package:ugbills/models/api/transactions_model.dart';
import 'package:ugbills/screens/user/home/transaction/receipt.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class TransactionDetails extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetails({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    ScreenshotController screenshotController = ScreenshotController();

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  color: ZealPalette.primaryBlue,
                  image: DecorationImage(
                    image: AssetImage("assets/images/bcc.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShadAvatar(
                      transaction.type == "electricity"
                          ? ZeelSvg.electricity
                          : transaction.type == "cabletv"
                              ? ZeelSvg.cable
                              : transaction.type == "betting"
                                  ? ZeelSvg.bet
                                  : (transaction.type == "data" ||
                                          transaction.type == "airtime")
                                      ? getNetWorkIcon(transaction
                                                  .product?.name ??
                                              "MTN")
                                          .toString()
                                      : transaction.type == "buy_crypto" ||
                                              transaction.type == "sell_crypto"
                                          ? getCryptoIcon(
                                                  transaction.product?.name ??
                                                      "BTC")
                                              .toString()
                                          : transaction.type == "coupon"
                                              ? ZeelSvg.coupon
                                              : transaction.type == "transfer"
                                                  ? ZeelSvg.money
                                                  : transaction.type ==
                                                          "virtual_card"
                                                      ? ZeelSvg.vc
                                                      : transaction.type ==
                                                              "reward"
                                                          ? ZeelSvg.reward
                                                          : transaction.type ==
                                                                  "giftcard"
                                                              ? transaction
                                                                      .product
                                                                      ?.name ??
                                                                  "Gift"
                                                              : ZeelSvg.money,
                      size: const Size(70, 70),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        "₦${returnAmount(transaction.amount)}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ZealPalette.lightGreen,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Text(
                        "Completed",
                        style: TextStyle(
                          color: ZealPalette.successGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height / 1.89,
                decoration: BoxDecoration(
                  color: isDark ? ZealPalette.lighterBlack : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Transaction details"),
                    const SizedBox(height: 12),
                    showDetails("Transaction Type",
                        transaction.type?.toUpperCase() ?? "N/A", context),
                    showDetails("Transaction ID",
                        transaction.reference?.toUpperCase() ?? "N/A", context),
                    showDetails("Date & time",
                        formartDateTime(transaction.createdAt ?? ""), context),
                    showDetails(
                        "Recipient", transaction.beneficiary ?? "N/A", context),
                    showDetails("Amount",
                        "₦${returnAmount(transaction.amount)}", context),
                    showDetails("Description", transaction.description ?? "N/A",
                        context),
                    showDetails("Status", transaction.status ?? "N/A", context),
                    const Spacer(),
                    ZeelButton(
                      text: "Share Transaction",
                      onPressed: () async {
                        var receipt = buildReciept(transaction: transaction);
                        await TransactionHelper().shareReceipt(
                            context: context,
                            receipt: receipt,
                            controller: screenshotController);
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var receipt = buildReciept(transaction: transaction);
                      await TransactionHelper().shareReceipt(
                          context: context,
                          receipt: receipt,
                          controller: screenshotController);
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget showDetails(String lead, String trail, BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lead,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        Flexible(
          child: Text(
            textAlign: TextAlign.end,
            overflow: TextOverflow.clip,
            trail,
            style: TextStyle(
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
