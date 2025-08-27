import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-2/kyc.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-3/address.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class AccountLevel extends ConsumerWidget {
  const AccountLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(fetchUserInformationProvider);
    var accountLevel = ref.watch(fetchAccountLevelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Level"),
        centerTitle: true,
        leadingWidth: 100,
        forceMaterialTransparency: true,
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: user.when(
              error: (error, _) => const Text("An error occurred"),
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (user) => accountLevel.when(
                  error: (error, _) => Text(error.toString()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  data: (levels) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return selectedTier(
                                      user!.data!.level! ==
                                          levels.data![index].levelId!,
                                      levels.data![index].name!.toUpperCase(),
                                      "₦${returnAmount(levels.data![index].amountPerDay)}",
                                      levels.data![index].levelId!.toString(),
                                      levels.data![index].totalBalance,
                                      context);
                                },
                                itemCount: levels!.data!.length,
                                shrinkWrap: true),
                          ),
                          user!.data!.level! < 3
                              ? Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: ZeelButton(
                                    text:
                                        "Upgrade to Tier ${user.data!.level! + 1}",
                                    onPressed: () {
                                      Go.to(user.data!.level! == 1
                                          ? const KYCVerification()
                                          : EnterAddress());
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ))),
        ),
      ),
    );
  }
}

Widget selectedTier(bool selected, String tier, String limit, String fig,
    dynamic maximumBalance, BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return Container(
    margin: const EdgeInsets.only(top: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: isDark
          ? ZealPalette.lighterBlack
          : selected
              ? ZealPalette.lightestPurple
              : Colors.white,
      border: Border.all(
        color: isDark && !selected
            ? ZealPalette.lighterBlack
            : isDark && selected
                ? ZealPalette.lightPurple
                : selected
                    ? ZealPalette.primaryPurple
                    : Colors.white,
      ),
    ),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: isDark && !selected
                ? ZealPalette.lighterBlack
                : isDark && selected
                    ? ZealPalette.lightPurple
                    : selected
                        ? ZealPalette.primaryPurple
                        : Colors.white,
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Image.asset("assets/images/tier-$fig.png"),
              const SizedBox(width: 6),
              Text(
                tier,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? Colors.white
                        : selected
                            ? Colors.white
                            : Colors.black),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Daily transfer limit",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    limit,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Max Balance",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    maximumBalance == 0
                        ? "Unlitmited"
                        : "₦${returnAmount(maximumBalance)}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
