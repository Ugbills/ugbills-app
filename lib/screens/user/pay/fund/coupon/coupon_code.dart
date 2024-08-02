import 'package:flutter/material.dart';
import 'package:zeelpay/screens/user/pay/fund/coupon/coupon_completed.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 100,
          title: const Text("Coupon Code"),
          leading: const ZeelBackButton()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const ZeelTextFieldTitle(text: "Code"),
              const ZeelTextField(
                hint: "X3Od1ke3",
                enabled: true,
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: ZeelButton(
                  text: "Confirm Deposit",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CouponCompleted()));
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
