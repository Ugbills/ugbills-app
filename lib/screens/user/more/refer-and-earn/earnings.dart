import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/more/refer-and-earn/history.dart';
import 'package:ugbills/screens/user/more/refer-and-earn/referral_tile.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class ReferralEarnings extends ConsumerStatefulWidget {
  const ReferralEarnings({super.key});

  @override
  ConsumerState<ReferralEarnings> createState() => _ReferralEarningsState();
}

class _ReferralEarningsState extends ConsumerState<ReferralEarnings> {
  bool _stealth = false;

  @override
  Widget build(BuildContext context) {
    var referrals = ref.watch(fetchUserReferralsProvider);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        title: const Text("Referral History"),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: referrals.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text("Error: $error")),
            data: (referrals) => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24)
                      .copyWith(top: 24),
                  children: [
                    showBalance(
                      _stealth
                          ? "***********"
                          : "₦${returnAmount(referrals!.data!.balance!)}",
                      () {
                        setState(() {
                          _stealth = !_stealth;
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
                                    color: ZealPalette.primaryBlue,
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
                    ReferralTile(
                      referrals: referrals!,
                    ),
                  ],
                )),
      ),
    );
  }
}

Widget showBalance(String balance, Function()? onPressed) {
  return Container(
    padding: const EdgeInsets.all(24),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: ZealPalette.primaryBlue,
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
