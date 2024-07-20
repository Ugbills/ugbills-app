import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/screens/user/bills/widgets/widgets.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class DataBills extends StatelessWidget {
  const DataBills({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = ShadTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Data'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: ZeelScrollable(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZeelNetwork(
                    icon: ZeelPng.mtn,
                  ),
                  ZeelNetwork(
                    icon: ZeelPng.airtel,
                  ),
                  ZeelNetwork(
                    icon: ZeelPng.glo,
                  ),
                  ZeelNetwork(
                    icon: ZeelPng.mobile,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const ZeelTextFieldTitle(text: "Select Data Plan"),
              const ZeelSelectTextField(hint: "Choose a Plan"),
              const SizedBox(
                height: 5,
              ),
              const ZeelTextFieldTitle(text: "Phone Number"),
              const ZeelTextField(hint: "0800 000 0000", enabled: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose Contact",
                    style: theme.textTheme.small,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const ZeelTextFieldTitle(text: "Amount"),
              const ZeelTextField(hint: "NGN1000", enabled: false),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Balance: "),
                  Text(
                    "₦0.00",
                    style: theme.textTheme.small,
                  )
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ZeelButton(
                    text: "Buy",
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
