import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/more/refer-and-earn/referral_tile.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class ReferralHistory extends ConsumerWidget {
  const ReferralHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var referrals = ref.watch(fetchUserReferralsProvider);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        title: const Text("Referral History"),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: referrals.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text("Error: $error")),
              data: (referrals) => ReferralTile(
                    referrals: referrals!,
                  )),
        ),
      ),
    );
  }
}
