import 'package:flutter/material.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/themes/palette.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List activity = [
      ["MTN Airtime", "06:59 PM • 07 Mar", "₦3,000", false],
      ["Bitcoin Trade", "06:59 PM • 07 Mar", "₦15,000", true],
      ["EKEDC 23024343", "06:59 PM • 07 Mar", "₦8,000", true],
      ["GLO Data", "06:59 PM • 07 Mar", "₦5,000", false],
      ["DSTV", "06:59 PM • 07 Mar", "₦13,000", false],
    ];
    return activity.isEmpty
        ? const Center(
            child: Text(
              "No activity Yet!",
              style: TextStyle(color: Colors.grey),
            ),
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activity.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(ZeelPng.mtn_2, height: 46),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity[index][0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                activity[index][1],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        activity[index][2],
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: activity[index][3]
                              ? ZealPalette.successGreen
                              : ZealPalette.errorRed,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ]);
            });
  }
}
