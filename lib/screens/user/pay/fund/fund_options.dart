import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/screens/user/pay/fund/bank/amount.dart';
import 'package:zeelpay/screens/user/pay/fund/bank/bank_transfer.dart';
import 'package:zeelpay/screens/user/pay/fund/coupon/coupon_code.dart';
import 'package:zeelpay/screens/user/widgets/zeel_tile.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class FundOptions extends StatelessWidget {
  const FundOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 100,
        title: Text("Fund Your Account",
            style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ZeelTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VirtualAccount())),
                title: "Virtual Account",
                subtitle: "Transfer funds directly from your bank account.",
                leadingImage: ZeelPng.bankTransfer),
            ZeelTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FundAmountScreen())),
                title: "Bank Transfer (One-time)",
                subtitle: "Transfer funds directly from your bank account.",
                leadingImage: ZeelPng.bankTransfer),
            ZeelTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CouponCode())),
                title: "Coupon Code",
                subtitle: "Redeem a coupon code for a special offer or bonus.",
                leadingImage: ZeelPng.coupon)
          ],
        ),
      ),
    );
  }
}
