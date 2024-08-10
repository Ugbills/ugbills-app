import 'package:flutter/material.dart';
import 'package:zeelpay/screens/user/more/refer-and-earn/history.dart';
import 'package:zeelpay/screens/user/more/refer-and-earn/referral_tile.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ReferralEarnings extends StatefulWidget {
  const ReferralEarnings({super.key});

  @override
  State<ReferralEarnings> createState() => _ReferralEarningsState();
}

class _ReferralEarningsState extends State<ReferralEarnings> {
  bool _stealth = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        title: const Text("Referral History"),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
          children: [
            showBalance(
              _stealth ? "***********" : "₦73,000.00",
              () {
                setState(() {
                  _stealth = !_stealth;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ZeelTextFieldTitle(text: "Referral Status"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReferralHistory(),
                          ));
                    },
                    child: Row(
                      children: [
                        const ZeelTextFieldTitle(text: "View all"),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ZealPalette.primaryPurple,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const ReferralTile(),
          ],
        ),
      ),
    );
  }
}

Widget showBalance(String balance, Function()? onPressed) {
  return Container(
    padding: const EdgeInsets.all(24),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: ZealPalette.primaryPurple,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      children: [
        const Text(
          "Total Earnings",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              balance,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
