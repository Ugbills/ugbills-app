import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/screens/user/pay/airtime/airtime.dart';
import 'package:ugbills/screens/user/pay/betting/betting.dart';
import 'package:ugbills/screens/user/pay/data/data.dart';
import 'package:ugbills/screens/user/pay/data/internet_data.dart';
import 'package:ugbills/screens/user/pay/data/sme_data.dart';
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
      icon: ZeelSvg.cables,
      color: ZealPalette.lightBlue,
    ),
    ZeelActionButton(
      onTap: () {
        showModalBottomSheet(
            isDismissible: true,
            useSafeArea: true,
            context: context,
            builder: (context) => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border(
                          top: BorderSide(
                              width: 0.5,
                              color:
                                  ShadTheme.of(context).colorScheme.primary))),
                  child: Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DataBills(),
                            ),
                          );
                        },
                        subtitle:
                            const Text("Purchase data bundles with cashback"),
                        title: Text("Data Bundle",
                            style:
                                ShadTheme.of(context).textTheme.small.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                    )),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SMEDataBills(),
                            ),
                          );
                        },
                        subtitle: const Text("Purchase SME data plans"),
                        title: Text("SME Data",
                            style:
                                ShadTheme.of(context).textTheme.small.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                    )),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InternetDataBills(),
                            ),
                          );
                        },
                        subtitle: const Text("Purchase internet data plans"),
                        title: Text("Internet Data",
                            style:
                                ShadTheme.of(context).textTheme.small.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20,
                                    )),
                      ),
                    ],
                  ),
                ));
      },
      text: "Buy Data",
      icon: ZeelSvg.wifi,
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
      icon: ZeelSvg.contact,
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
      icon: ZeelSvg.swap,
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
      icon: ZeelSvg.power,
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
        icon: ZeelSvg.soccer,
        color: ZealPalette.lightBlue),
  ];
}
