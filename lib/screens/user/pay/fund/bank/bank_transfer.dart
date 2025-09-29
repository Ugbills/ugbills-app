import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/controllers/wallet/wallet_controller.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class VirtualAccount extends ConsumerWidget {
  const VirtualAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var depositDetails = ref.watch(fetchMobileDepositDetailsProvider);

    return Scaffold(
        appBar: AppBar(
            forceMaterialTransparency: true,
            leadingWidth: 100,
            title: const Text("Bank Transfer"),
            leading: const ZeelBackButton()),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please go to your bank’s website or app and initiate a transfer to the following account details:",
                        style: ShadTheme.of(context).textTheme.muted,
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // // Deposit Details Section
                      // depositDetails.when(
                      //   loading: () =>
                      //       const Center(child: CircularProgressIndicator()),
                      //   error: (error, stack) => Container(),
                      //   data: (details) => details != null
                      //       ? Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               "Bank Deposit Information",
                      //               style: ShadTheme.of(context)
                      //                   .textTheme
                      //                   .h4
                      //                   .copyWith(
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //             ),
                      //             const SizedBox(height: 16),
                      //             Container(
                      //               padding: const EdgeInsets.all(16),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.blue.withOpacity(0.1),
                      //                 borderRadius: BorderRadius.circular(8),
                      //                 border: Border.all(
                      //                     color: Colors.blue.withOpacity(0.3)),
                      //               ),
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   _buildInfoRow("Bank Name:",
                      //                       details.bankName ?? "N/A"),
                      //                   const SizedBox(height: 8),
                      //                   _buildInfoRow("Account Number:",
                      //                       details.accountNumber ?? "N/A"),
                      //                   const SizedBox(height: 8),
                      //                   _buildInfoRow("Transfer Fee:",
                      //                       "₦\${details.transferFee ?? 0}"),
                      //                   const SizedBox(height: 8),
                      //                   _buildInfoRow("Min Amount:",
                      //                       "₦\${details.bankDepositMinAmount ?? 100}"),
                      //                   const SizedBox(height: 8),
                      //                   _buildInfoRow("Max Amount:",
                      //                       "₦\${details.bankDepositMaxAmount ?? 10000}"),
                      //                 ],
                      //               ),
                      //             ),
                      //             const SizedBox(height: 30),
                      //             const Divider(),
                      //             const SizedBox(height: 20),
                      //           ],
                      //         )
                      //       : Container(),
                      // ),

                      // Virtual Accounts Section
                      const SizedBox(height: 16),
                      depositDetails.when(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) => Text("Error: $error"),
                          data: (accounts) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ZeelTextFieldTitle(text: "Bank Name"),
                                  ZeelTextField(
                                    hint: accounts!.bankName!,
                                    enabled: false,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const ZeelTextFieldTitle(
                                      text: "Account Number"),
                                  ZeelTextField(
                                    hint: accounts.accountNumber,
                                    copy: true,
                                    enabled: false,
                                    controller: TextEditingController(
                                        text: accounts.accountNumber),
                                  ),
                                ],
                              ))
                    ]),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ZeelButton(
            text: "Log Deposit",
            onPressed: () {
              _showDepositDialog(context, ref);
            },
          ),
        ));
  }

  // Widget _buildInfoRow(String label, String value) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 14,
  //         ),
  //       ),
  //       Text(
  //         value,
  //         style: const TextStyle(
  //           fontSize: 14,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void _showDepositDialog(BuildContext context, WidgetRef ref) {
    final amountController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Deposit'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter the amount you deposited to the bank account above:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount (₦)',
                  prefixText: '₦ ',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount < 100) {
                    return 'Minimum amount is ₦100';
                  }
                  if (amount > 10000) {
                    return 'Maximum amount is ₦10,000';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop();
                final amount = double.parse(amountController.text);

                await ref.read(walletControllerProvider.notifier).logDeposit(
                      amount: amount,
                      context: context,
                      ref: ref,
                    );
              }
            },
            child: const Text('Log Deposit'),
          ),
        ],
      ),
    );
  }
}
