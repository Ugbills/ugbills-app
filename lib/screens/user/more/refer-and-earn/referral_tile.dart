import 'package:flutter/material.dart';
import 'package:ugbills/models/api/referrals_model.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/themes/palette.dart';

class ReferralTile extends StatelessWidget {
  final ReferralsModel referrals;
  const ReferralTile({super.key, required this.referrals});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return referrals.data!.referrals!.isEmpty
        ? const Center(
            child: Text("No Referral Yet!"),
          )
        : ListView.builder(
            itemCount: referrals.data!.referrals!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _showTiles(
                isDark: isDark,
                name: referrals.data!.referrals![index].name!,
                date: referrals.data!.referrals![index].createdAt!,
                isPending:
                    referrals.data!.referrals![index].status == "waiting",
              );
            },
          );
  }

  Container _showTiles(
      {required bool isDark,
      required String name,
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
                date,
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
