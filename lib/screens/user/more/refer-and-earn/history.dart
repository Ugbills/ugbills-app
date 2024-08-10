import 'package:flutter/material.dart';
import 'package:zeelpay/screens/user/more/refer-and-earn/referral_tile.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class ReferralHistory extends StatelessWidget {
  const ReferralHistory({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final List referrals = [
      ["March 2024", const ReferralTile()],
      ["February 2024", const ReferralTile()],
      ["January 2024", const ReferralTile()]
    ];

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        title: const Text("Referral History"),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: referrals.length,
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade500,
                  ),
                  child: Text(
                    referrals[index][0],
                    style: TextStyle(
                      fontSize: 10,
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade200,
                    ),
                  ),
                ),
                referrals[index][1],
              ],
            );
          },
        ),
      ),
    );
  }
}
