import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class BankTransactionDetails extends StatelessWidget {
  final String bankLogo,
      amount,
      transactionID,
      dateAndTime,
      bankName,
      accountName,
      accountNumber,
      fee,
      sessionId,
      note;
  const BankTransactionDetails({
    super.key,
    required this.bankLogo,
    required this.amount,
    required this.transactionID,
    required this.dateAndTime,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    required this.fee,
    required this.note,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

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
                    ShadImage(
                      bankLogo,
                      height: 70,
                      width: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        amount,
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
                    showDetails("Transaction ID", transactionID, context),
                    showDetails("Date & time", dateAndTime, context),
                    showDetails("Bank Name", bankName, context),
                    showDetails("Account Name", accountName, context),
                    showDetails("Account Number", accountNumber, context),
                    showDetails("Fee", fee, context),
                    showDetails("Note", note, context),
                    showDetails("Session ID", sessionId, context),
                    const Spacer(),
                    ZeelButton(
                      text: "Share Transaction",
                      onPressed: () {},
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
                    onPressed: () {},
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
        Text(
          trail,
          style: TextStyle(
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade900,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
