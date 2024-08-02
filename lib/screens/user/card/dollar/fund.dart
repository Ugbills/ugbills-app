import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/user/pay/send/bank/bank.dart';
import 'package:zeelpay/screens/widgets/number_pad.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class FundCard extends ConsumerWidget {
  const FundCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = ShadTheme.of(context);
    var amount = ref.watch(amountProvider);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      appBar: AppBar(
        title: const Text('Send Money',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ShadImage(ZeelSvg.tag),
          )
        ],
        backgroundColor: theme.colorScheme.primary,
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
                    children: [
                      Text(
                        "Amount",
                        style:
                            theme.textTheme.small.copyWith(color: Colors.white),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            "Balance: ",
                            style: theme.textTheme.small
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "₦12,073,000.00",
                            style: theme.textTheme.small.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
            // Number Pad Section Starts Here
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            // NUMBER PAD
            ZeelNumberPad(
              provider: amountProvider,
              ref: ref,
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ZeelAltButton(
                      onPressed: amount == "0.00"
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) {
                                        return const BankTransfer();
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
