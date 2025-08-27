// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/controllers/transfer/transfer_controller.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class OneTimeBankAccountView extends ConsumerWidget {
  final String amount;
  const OneTimeBankAccountView({super.key, required this.amount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var onetime =
        ref.watch(oneTimeAccountProvider(amount: amount.replaceAll(",", "")));

    var isloading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 100,
        title: Text("One-Time Transfer",
            style: ShadTheme.of(context).textTheme.large),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: ZeelScrollable(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: onetime.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                  child: Text(error.toString().replaceAll("Exception:", ""))),
              data: (account) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transfer ₦$amount to the account below",
                    style: ShadTheme.of(context)
                        .textTheme
                        .large
                        .copyWith(color: const Color(0xff9C2631)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      "Do not save the account details below, it expires in 15minutes from now, and make sure you transfer only once to this account."),
                  const SizedBox(
                    height: 30,
                  ),
                  const ZeelTextFieldTitle(text: "Bank Name"),
                  const SizedBox(
                    height: 5,
                  ),
                  ZeelTextField(
                    hint: account!.data!.bankName!,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const ZeelTextFieldTitle(text: "Account Name"),
                  const SizedBox(
                    height: 5,
                  ),
                  ZeelTextField(
                    hint: account.data!.accountName!,
                    enabled: false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const ZeelTextFieldTitle(text: "Account Number"),
                  const SizedBox(
                    height: 5,
                  ),
                  ZeelTextField(
                    hint: account.data!.accountNumber!,
                    controller: TextEditingController()
                      ..text = account.data!.accountNumber!,
                    enabled: false,
                    copy: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "Expires in 15mins",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff9C2631),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ZeelButton(
                              text: "I have transferred",
                              isLoading: isloading,
                              onPressed: () async => await confirmTransfer(
                                    context: context,
                                    ref: ref,
                                    reference: account.data!.reference!,
                                  )),
                          const SizedBox(
                            height: 10,
                          ),
                          ZeelAltButton(
                              text: "Cancel Deposit",
                              onPressed: () => Go.back()),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
