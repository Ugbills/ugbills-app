import 'package:flutter/material.dart';
import 'package:ugbills/screens/user/more/account_level/tier-3/address.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class AccountTier3 extends StatelessWidget {
  const AccountTier3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  selectedTier(false, "Tier 1", "₦100,000", "1", context),
                  selectedTier(false, "Tier 2", "₦150,000", "2", context),
                  selectedTier(true, "Tier 3", "₦1,000,000", "3", context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ZeelButton(
                text: "Upgrade to Tier 3",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EnterAddress(),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget selectedTier(bool selected, String tier, String limit, String fig,
    BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return Container(
    margin: const EdgeInsets.only(top: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: isDark
          ? ZealPalette.lighterBlack
          : selected
              ? ZealPalette.lightestBlue
              : Colors.white,
      border: Border.all(
        color: isDark && !selected
            ? ZealPalette.lighterBlack
            : isDark && selected
                ? ZealPalette.lightBlue
                : selected
                    ? ZealPalette.primaryBlue
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
                    ? ZealPalette.lightBlue
                    : selected
                        ? ZealPalette.primaryBlue
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Max Balance",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Unlimited",
                    style: TextStyle(fontWeight: FontWeight.w600),
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
