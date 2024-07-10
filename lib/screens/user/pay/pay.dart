import 'package:flutter/material.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/user/widgets/action_button.dart';

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              itemCount: _buildMenuItems().length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return _buildMenuItems()[index];
              },
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> _buildMenuItems() {
  return [
    const ZeelActionButton(
      text: "Fund",
      icon: ZeelSvg.fund,
      color: Color(0xffFFC9CE),
    ),
    const ZeelActionButton(
      text: "Send",
      icon: ZeelSvg.send,
      color: Color(0xffFFD3B3),
    ),
    const ZeelActionButton(
      text: "TV",
      icon: ZeelSvg.tv,
      color: Color(0xffCFC6FF),
    ),
    const ZeelActionButton(
      text: "Buy Data",
      icon: ZeelSvg.data,
      color: Color(0xffFED4FF),
    ),
    const ZeelActionButton(
      text: "Buy Airtime",
      icon: ZeelSvg.airtime,
      color: Color(0xffB6E1FF),
    ),
    const ZeelActionButton(
        text: "Gift Card", icon: ZeelSvg.betting, color: Color(0xffE0FFAE)),
    const ZeelActionButton(
        text: "Airtime Swap", icon: ZeelSvg.betting, color: Color(0xffAEFFCF)),
    const ZeelActionButton(
        text: "Electricity", icon: ZeelSvg.betting, color: Color(0xffFFC7AE)),
    const ZeelActionButton(
        text: "Betting", icon: ZeelSvg.betting, color: Color(0xffAECAFF)),
  ];
}
