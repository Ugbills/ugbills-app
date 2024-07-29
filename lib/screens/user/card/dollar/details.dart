import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Card Details", style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const ZeelTextFieldTitle(text: "Card Number"),
          ZeelTextField(
              controller: TextEditingController(text: "2084 2308 2304 2304"),
              enabled: false,
              copy: true),
          const ZeelTextFieldTitle(text: "Card Number"),
          ZeelTextField(
              enabled: false,
              controller: TextEditingController(text: "12/12"),
              copy: true),
          const ZeelTextFieldTitle(text: "Card Number"),
          ZeelTextField(
              controller: TextEditingController(text: "234"),
              enabled: false,
              copy: true),
          const ZeelTextFieldTitle(text: "Card Number"),
          ZeelTextField(
              controller: TextEditingController(
                  text: "12 Big Zee towers, Washington DC"),
              enabled: false,
              copy: true),
        ],
      ),
    );
  }
}
