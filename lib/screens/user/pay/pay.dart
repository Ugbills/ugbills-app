import 'package:flutter/material.dart';
import 'package:zeelpay/constants/assets/svg.dart';
import 'package:zeelpay/screens/user/pay/airtime/airtime.dart';
import 'package:zeelpay/screens/user/pay/betting/betting.dart';
import 'package:zeelpay/screens/user/pay/data/data.dart';
import 'package:zeelpay/screens/user/pay/electricity/electricity.dart';
import 'package:zeelpay/screens/user/pay/swap/swap.dart';
import 'package:zeelpay/screens/user/pay/tv/tv.dart';
import 'package:zeelpay/screens/user/pay/fund/fund_options.dart';
import 'package:zeelpay/screens/user/pay/giftcard/giftcard.dart';
import 'package:zeelpay/screens/user/pay/send/amount_screen.dart';
import 'package:zeelpay/screens/user/widgets/action_button.dart';

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pay'),
        leading: const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _buildMenuItems(context).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return _buildMenuItems(context)[index];
              },
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildMenuItems(BuildContext context) {
  return [
    ZeelActionButton(
      text: "Fund",
      icon: ZeelSvg.fund,
      color: const Color(0xffFFC9CE),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FundOptions(),
          ),
        );
      },
    ),
    ZeelActionButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AmountScreen(),
          ),
        );
      },
      text: "Send",
      icon: ZeelSvg.send,
      color: const Color(0xffFFD3B3),
    ),
    ZeelActionButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TVBills(),
          ),
        );
      },
      text: "TV",
      icon: ZeelSvg.tv,
      color: const Color(0xffCFC6FF),
    ),
    ZeelActionButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DataBills(),
          ),
        );
      },
      text: "Buy Data",
      icon: ZeelSvg.data,
      color: const Color(0xffFED4FF),
    ),
    ZeelActionButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AirtimeBills(),
          ),
        );
      },
      text: "Buy Airtime",
      icon: ZeelSvg.airtime,
      color: const Color(0xffB6E1FF),
    ),
    ZeelActionButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GiftcardScreen(),
            ),
          );
        },
        text: "Gift Card",
        icon: ZeelSvg.betting,
        color: const Color(0xffE0FFAE)),
    ZeelActionButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AirtimeSwap(),
            ),
          );
        },
        text: "Airtime Swap",
        icon: ZeelSvg.betting,
        color: const Color(0xffAEFFCF)),
    ZeelActionButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ElectricityBills(),
            ),
          );
        },
        text: "Electricity",
        icon: ZeelSvg.betting,
        color: const Color(0xffFFC7AE)),
    ZeelActionButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BettingBills(),
            ),
          );
        },
        text: "Betting",
        icon: ZeelSvg.betting,
        color: const Color(0xffAECAFF)),
  ];
}
