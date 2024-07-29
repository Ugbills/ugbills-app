import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/screens/user/send/sent.dart';
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
                    ))
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
                    Text("Save Beneficiary",
                        style: theme.textTheme.small.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold))
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
                            showDetails("Amount", "₦10,000.00"),
                            showDetails("Bank Name", "Access Bank"),
                            showDetails("Account Name", "Mary Doe"),
                            showDetails("Account Name", "1038344233"),
                            showDetails("Fee", "₦10.00"),
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

Widget showDetails(String lead, String trail) {
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
          style: TextStyle(color: Colors.grey.shade900),
        ),
      ],
    ),
  );
}

final saveBeneficiaryProvider = StateProvider<bool>((ref) {
  return false;
});
