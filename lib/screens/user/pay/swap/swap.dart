import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/controllers/bills/airtime_controller.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/providers/network_provider.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/pay/swap/swap_result.dart';
import 'package:ugbills/screens/user/widgets/widgets.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';

class AirtimeSwap extends ConsumerStatefulWidget {
  const AirtimeSwap({super.key});

  @override
  ConsumerState<AirtimeSwap> createState() => _AirtimeSwapState();
}

class _AirtimeSwapState extends ConsumerState<AirtimeSwap> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  var _selectedNetwork = "";

  @override
  Widget build(BuildContext context) {
    var networks = ref.watch(getNetworksProvider);
    var user = ref.watch(fetchUserInformationProvider);
    var isloading = ref.watch(isLoadingProvider);
    var theme = ShadTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Airtime to Cash'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: ZeelScrollable(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                networks.when(
                  data: (network) => SizedBox(
                    height: 80,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ZeelNetwork(
                            icon: network.data![index].icon!,
                            selected:
                                _selectedNetwork == network.data![index].id,
                            onTap: () {
                              setState(() {
                                _selectedNetwork = network.data![index].id!;
                              });
                            },
                          );
                        },
                        itemCount: network!.data!.length),
                  ),
                  error: (error, _) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const ZeelTextFieldTitle(text: "Amount to buy"),
                ZeelTextField(
                    hint: "Enter amount",
                    enabled: true,
                    keyboardType: TextInputType.number,
                    controller: _amountController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ZeelQuickAmount(
                      theme: theme,
                      text: "₦100",
                      onTap: () {
                        _amountController.text = "100";
                      },
                    ),
                    ZeelQuickAmount(
                      theme: theme,
                      text: "₦200",
                      onTap: () {
                        _amountController.text = "200";
                      },
                    ),
                    ZeelQuickAmount(
                      theme: theme,
                      text: "₦500",
                      onTap: () {
                        _amountController.text = "500";
                      },
                    ),
                    ZeelQuickAmount(
                      theme: theme,
                      text: "₦1000",
                      onTap: () {
                        _amountController.text = "1000";
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                user.when(
                    data: (data) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Balance: "),
                            Text(
                              "₦${returnAmount(data!.data!.walletBalance)}",
                              style: theme.textTheme.small,
                            )
                          ],
                        ),
                    error: (error, _) => Text(error.toString()),
                    loading: () => const SizedBox.shrink()),
                const SizedBox(
                  height: 10,
                ),
                const ZeelTextFieldTitle(text: "Phone Number"),
                ZeelTextField(
                  hint: "Enter Phone Number",
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  enabled: true,
                  controller: _phoneNumberController,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     GestureDetector(
                //       onTap: () async {
                //         try {
                //           final PhoneContact contact =
                //               await FlutterContactPicker.pickPhoneContact();

                //           if (contact.phoneNumber == null) return;

                //           _phoneNumberController.text =
                //               ContactFormat().contact(contact).toString();

                //           FocusScope.of(context).unfocus();

                //           setState(() {
                //             _selectedNetwork = NetworkHelper()
                //                 .getNetworkId(
                //                     beneficiary: _phoneNumberController.text)
                //                 .toString();
                //           });
                //         } catch (e) {
                //           log(e.toString());
                //         }
                //       },
                //       child: Text(
                //         "Choose Contact",
                //         style: theme.textTheme.small,
                //       ),
                //     )
                //   ],
                // ),
                // const SizedBox(height: 24),
                // const ZeelTextFieldTitle(text: "Share N Sell PIN"),
                // ZeelTextField(
                //     enabled: true,
                //     keyboardType: TextInputType.number,
                //     hint: "Enter share N Sell Pin",
                //     controller: _pinController),
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(16),
                //     color: isDark
                //         ? ZealPalette.orange
                //         : ZealPalette.rustColor.withAlpha(20),
                //     border: Border.all(color: ZealPalette.rustColor),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const Text(
                //         "Note",
                //         style: TextStyle(
                //           color: ZealPalette.rustColor,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       Text(
                //         "Share n Sell pin allows you transfer airtime from one MTN user to another.",
                //         style: TextStyle(
                //           color: isDark ? ZealPalette.rustColor : Colors.grey,
                //           fontSize: 10,
                //         ),
                //       )
                //     ],
                //   ),
                // ),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ZeelButton(
                      isLoading: isloading,
                      text: "Swap",
                      onPressed: () async {
                        if (_amountController.text.isEmpty ||
                            _phoneNumberController.text.isEmpty ||
                            _selectedNetwork.isEmpty) {
                        } else {
                          var swap = await startSwap(
                              ref: ref,
                              phoneNumber: _phoneNumberController.text,
                              amount: int.parse(_amountController.text),
                              network: _selectedNetwork);

                          if (swap != null) {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Wrap(
                                    children: [
                                      Center(
                                        child: Text(
                                          "You are about to convert ₦${returnAmount(swap.pay)} airtime to cash.",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "You will receive:",
                                          ),
                                          Text(
                                            "₦${returnAmount(swap.receive)}",
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Convertion Rate:",
                                          ),
                                          Text(
                                            "${swap.swapPercent}%",
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Transfer Airtime to:",
                                          ),
                                          Text(
                                            swap.sendTo!,
                                          )
                                        ],
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ZeelButton(
                                        text: "i have transferred",
                                        onPressed: () {
                                          Go.to(SwapResult(
                                            networkId: _selectedNetwork,
                                            amount: _amountController.text,
                                            phoneNumber:
                                                _phoneNumberController.text,
                                          ));
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
