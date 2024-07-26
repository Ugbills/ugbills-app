import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-2/tier_2.dart';
import 'package:zeelpay/screens/user/more/profile/edit.dart';
import 'package:zeelpay/screens/user/more/refer-and-earn/refer_and_earn.dart';
import 'package:zeelpay/screens/user/more/statement/statement.dart';
import 'package:zeelpay/screens/user/widgets/zeel_tile.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const ShadImage(ZeelPng.avatar, height: 50),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("John Doe",
                              style: ShadTheme.of(context).textTheme.h4),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 70,
                            decoration: BoxDecoration(
                                color: const Color(0xffE9E6EB),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text("Tier 1")),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              backgroundColor: const Color(0xff20013A)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const EditProfile()));
                          },
                          child: Text(
                            "Edit Profile",
                            style: ShadTheme.of(context)
                                .textTheme
                                .small
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )))
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tiles.length,
                  itemBuilder: (context, index) {
                    return ZeelListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => tiles[index].route,
                            ),
                          );
                        },
                        title: tiles[index].title,
                        leadingIcon: tiles[index].leadingIcon);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Tiles> tiles = [
  Tiles(
    title: "Account Statement",
    leadingIcon: ZeelSvg.accountStatement,
    route: const AccountStatement(),
  ),
  Tiles(
    title: "Account Levels",
    leadingIcon: ZeelSvg.accountLevels,
    route: const AccountTier2(),
  ),
  Tiles(
    title: "Refer and Earn",
    leadingIcon: ZeelSvg.refer,
    route: const ReferAndEarn(),
  ),
  Tiles(title: "Beneficiaries", leadingIcon: ZeelSvg.beneficiary),
  Tiles(title: "Security Settings", leadingIcon: ZeelSvg.settings),
  Tiles(title: "Contact Us", leadingIcon: ZeelSvg.contact),
  Tiles(title: "About Us", leadingIcon: ZeelSvg.about),
  Tiles(title: "Logout", leadingIcon: ZeelSvg.logout),
];

class Tiles {
  final String title;
  final String leadingIcon;
  final Widget route;

  Tiles({
    required this.title,
    required this.leadingIcon,
    this.route = const AccountTier2(),
  });
}
