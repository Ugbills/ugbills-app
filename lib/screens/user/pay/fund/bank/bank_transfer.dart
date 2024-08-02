import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class VirtualAccount extends StatelessWidget {
  const VirtualAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 100,
          title: const Text("Bank Transfer"),
          leading: const ZeelBackButton()),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please go to your bank’s website or app and initiate a transfer to the following account details:",
                  style: ShadTheme.of(context).textTheme.muted,
                ),
                const SizedBox(
                  height: 30,
                ),
                const ZeelTextFieldTitle(text: "Account Name"),
                const ZeelTextField(
                  hint: "John Doe",
                  enabled: false,
                ),
                const SizedBox(
                  height: 5,
                ),
                const ZeelTextFieldTitle(text: "Account Number"),
                const ZeelTextField(
                  hint: "02840583443",
                  enabled: false,
                  copy: true,
                ),
                const SizedBox(
                  height: 5,
                ),
                const ZeelTextFieldTitle(text: "Bank Name"),
                const ZeelTextField(
                  hint: "Zeelpay Technologies Ltd",
                  enabled: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
