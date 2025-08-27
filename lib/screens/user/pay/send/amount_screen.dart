import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/widgets/number_pad.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class AmountScreen extends ConsumerWidget {
  final Widget page;
  const AmountScreen({super.key, required this.page});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = ShadTheme.of(context);
    var amount = ref.watch(amountProvider);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    var user = ref.watch(fetchUserInformationProvider);
    return Scaffold(
      backgroundColor:
          isDark ? ZealPalette.scaffoldBlack : theme.colorScheme.primary,
      appBar: AppBar(
        title: const Text(
          'Send Money',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: ZeelBackButton(
          color: isDark ? ZealPalette.scaffoldBlack : Colors.white,
        ),
        backgroundColor:
            isDark ? ZealPalette.scaffoldBlack : theme.colorScheme.primary,
        leadingWidth: 100,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount",
                        style:
                            theme.textTheme.small.copyWith(color: Colors.white),
                      ),
                      user.when(
                          loading: () => const SizedBox.shrink(),
                          error: (error, stack) => const SizedBox.shrink(),
                          data: (user) => Row(
                                children: [
                                  Text(
                                    "Balance: ",
                                    style: theme.textTheme.small
                                        .copyWith(color: Colors.white),
                                  ),
                                  Text(
                                    returnAmount(user!.data!.walletBalance),
                                    style: theme.textTheme.small.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "₦ $amount",
                    style: theme.textTheme.h2.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ZeelNumberPad(
              provider: amountProvider,
              ref: ref,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: ZeelAltButton(
                      onPressed: amount == "0.00" || amount == "0"
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) {
                                        return page;
                                      },
                                      settings:
                                          RouteSettings(arguments: amount)));
                            },
                      text: "Proceed",
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final amountProvider = StateProvider.autoDispose<String>((ref) {
  return "0.00";
});
