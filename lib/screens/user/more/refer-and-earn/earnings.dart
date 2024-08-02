import 'package:flutter/material.dart';
import 'package:zeelpay/screens/user/more/refer-and-earn/history.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class ReferralEarnings extends StatefulWidget {
  const ReferralEarnings({super.key});

  @override
  State<ReferralEarnings> createState() => _ReferralEarningsState();
}

class _ReferralEarningsState extends State<ReferralEarnings> {
  final List referrals = [
    ["Henry Eze", "06:59 PM", "18 Mar", false],
    ["Akin Layi", "06:59 PM", "18 Mar", false],
    ["Ogonna Iho", "06:59 PM", "18 Mar", true],
    ["Michael Ade", "06:59 PM", "18 Mar", false],
    ["Zainab Zee", "06:59 PM", "18 Mar", true],
    ["Abimbola Love", "06:59 PM", "18 Mar", true],
    ["Oyin Lawal", "06:59 PM", "18 Mar", false],
  ];

  bool stealth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
          children: [
            showBalance(
              stealth ? "***********" : "₦73,000.00",
              () {
                setState(() {
                  stealth = !stealth;
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
            if (referrals.isEmpty)
              const Center(
                child: Text("No Referral Yet!"),
              )
            else
              ListView.builder(
                itemCount: referrals.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return referralStatus(
                    referrals[index][3],
                    referrals[index][0],
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}

Widget showBalance(String balance, Function()? onPressed) {
  // bool show = true;
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

Widget referralStatus(bool isPending, String name) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZeelTextFieldTitle(text: name),
            const Text(
              "06:59 PM • 18 Mar",
              style: TextStyle(color: Colors.grey),
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
              color:
                  isPending ? ZealPalette.rustColor : ZealPalette.successGreen,
            ),
          ),
        ),
      ],
    ),
  );
}
