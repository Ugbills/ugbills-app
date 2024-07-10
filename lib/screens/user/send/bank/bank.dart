import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

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
                ZeelButton(
                  text: "Send",
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final saveBeneficiaryProvider = StateProvider<bool>((ref) {
  return false;
});

class ZeelScrollable extends StatelessWidget {
  final Widget child;
  const ZeelScrollable({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        reverse: true,
        slivers: [SliverFillRemaining(hasScrollBody: false, child: child)]);
  }
}
