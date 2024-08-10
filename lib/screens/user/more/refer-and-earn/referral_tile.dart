import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ReferralTile extends StatelessWidget {
  const ReferralTile({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final List referrals = [
      ["Henry Eze", "06:59 PM", "18 Mar", false],
      ["Akin Layi", "06:59 PM", "18 Mar", false],
      ["Ogonna Iho", "06:59 PM", "18 Mar", true],
      ["Michael Ade", "06:59 PM", "18 Mar", false],
      ["Zainab Zee", "06:59 PM", "18 Mar", true],
      ["Abimbola Love", "06:59 PM", "18 Mar", true],
      ["Oyin Lawal", "06:59 PM", "18 Mar", false],
    ];
    return referrals.isEmpty
        ? const Center(
            child: Text("No Referral Yet!"),
          )
        : ListView.builder(
            itemCount: referrals.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _showTiles(
                isDark: isDark,
                name: referrals[index][0],
                time: referrals[index][1],
                date: referrals[index][2],
                isPending: referrals[index][3],
              );
            },
          );
  }

  Container _showTiles(
      {required bool isDark,
      required String name,
      required String time,
      required String date,
      required bool isPending}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? ZealPalette.lighterBlack : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZeelTextFieldTitle(text: name),
              Text(
                "$time • $date",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: isPending ? ZealPalette.peach : ZealPalette.lightGreen,
            ),
            child: Text(
              isPending ? "Pending" : "Completed",
              style: TextStyle(
                color: isPending
                    ? ZealPalette.rustColor
                    : ZealPalette.successGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
