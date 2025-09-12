import 'package:flutter/material.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/screens/user/pay/airtime/airtime.dart';
import 'package:ugbills/screens/user/pay/betting/betting.dart';
import 'package:ugbills/screens/user/pay/data/data.dart';
import 'package:ugbills/screens/user/pay/electricity/electricity.dart';
import 'package:ugbills/screens/user/pay/swap/swap.dart';
import 'package:ugbills/screens/user/pay/tv/tv.dart';
import 'package:ugbills/screens/user/widgets/action_button.dart';
import 'package:ugbills/themes/palette.dart';

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pay'),
        forceMaterialTransparency: true,
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
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return [
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
      color: ZealPalette.lightBlue,
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
      color: ZealPalette.lightBlue,
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
      color: ZealPalette.lightBlue,
    ),
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
      color: ZealPalette.lightBlue,
    ),
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
      color: ZealPalette.lightBlue,
    ),
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
        color: ZealPalette.lightBlue),
  ];
}
