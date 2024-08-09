import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/more/beneficiaries/beneficiaries.dart';
import 'package:zeelpay/screens/user/pay/send/bank_transaction_details.dart';
import 'package:zeelpay/screens/widgets/sent.dart';
// import 'package:zeelpay/screens/user/pay/send/sent.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class BankTransfer extends ConsumerWidget {
  const BankTransfer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var saveBeneficiary = ref.watch(saveBeneficiaryProvider);
    var theme = ShadTheme.of(context);
    //GET amount from arguments
    final amount = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ZeelScrollable(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ZeelTextFieldTitle(text: "Amount"),
                ZeelTextField(hint: "₦$amount", enabled: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShadButton.link(
                      text: Text(
                        "Choose Beneficiary",
                        style: theme.textTheme.small.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          _createRoute(
                            const SavedBeneficiaries(),
                          ),
                        );
                      },
                    )
                  ],
                ),
                const ZeelTextFieldTitle(text: "Select a Bank"),
                ZeelSelectTextField(
                  hint: "Select a Bank",
                  onTap: () {},
                ),
                const ZeelTextFieldTitle(text: "Account Number"),
                const ZeelTextField(
                  hint: "Enter Account Number",
                  enabled: true,
                  copy: false,
                ),
                const ZeelTextFieldTitle(text: "Account Name"),
                const ZeelTextField(
                  hint: "OMERE OSAHENRHUMWEN KELLY",
                  enabled: false,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShadSwitch(
                      value: saveBeneficiary,
                      onChanged: (value) {
                        ref.read(saveBeneficiaryProvider.notifier).state =
                            value;
                      },
                    ),
                    Text(
                      "Save Beneficiary",
                      style: theme.textTheme.small.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const ZeelTextFieldTitle(text: "Note (Optional)"),
                const ZeelTextField(
                  hint: "Add a note",
                  enabled: true,
                ),
                const Spacer(),
                ZeelButton(
                  text: "Send",
                  onPressed: () {
                    showModalBottomSheet(
                      scrollControlDisabledMaxHeightRatio: double.maxFinite,
                      context: context,
                      builder: (_) => Container(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Confirm Details",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Image.asset("assets/images/x.png")),
                              ],
                            ),
                            showDetails("Amount", "₦10,000.00", context),
                            showDetails("Bank Name", "Access Bank", context),
                            showDetails("Account Name", "Mary Doe", context),
                            showDetails("Account Name", "1038344233", context),
                            showDetails("Fee", "₦10.00", context),
                            const SizedBox(height: 24),
                            ZeelButton(
                              text: "Confirm",
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SentSuccessfully(
                                        title: "Sent",
                                        body:
                                            "You have successfully sent ₦10,000 to Mary Doe.",
                                        nextPage: BankTransactionDetails(
                                          bankLogo: ZeelPng.firstbank,
                                          amount: "₦10,000",
                                          transactionID: "#2D94ty823",
                                          dateAndTime: "Mar 10 2023, 2:33PM",
                                          bankName: "First Bank of Nigeria",
                                          accountName: "243802003835",
                                          accountNumber: "243802003835",
                                          fee: "₦10.00",
                                          note: "None",
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget showDetails(String lead, String trail, BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
          ),
        ),
      ],
    ),
  );
}

final saveBeneficiaryProvider = StateProvider<bool>((ref) {
  return false;
});

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
