// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/controllers/bills/airtime_controller.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/network_helper.dart';
import 'package:ugbills/helpers/common/number_formarter.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/providers/network_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/widgets/widgets.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';

class AirtimeBills extends ConsumerStatefulWidget {
  const AirtimeBills({super.key});

  @override
  ConsumerState<AirtimeBills> createState() => _AirtimeBillsState();
}

class _AirtimeBillsState extends ConsumerState<AirtimeBills> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  var _selectedNetwork = "";

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var networks = ref.watch(getNetworksProvider);
    var user = ref.watch(fetchUserInformationProvider);
    var theme = ShadTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Airtime'),
        forceMaterialTransparency: true,
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: ZeelScrollable(
          child: SafeArea(
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
                          selected: _selectedNetwork == network.data![index].id,
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
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZeelTextField(
                      hint: "Enter amount",
                      enabled: true,
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      validator: amountValidator,
                    ),
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
                      height: 3,
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
                      height: 5,
                    ),
                    const ZeelTextFieldTitle(text: "Phone Number"),
                    ZeelTextField(
                      hint: "Enter phone number",
                      validator: phoneNumberValidator,
                      maxLength: 11,
                      keyboardType: TextInputType.phone,
                      enabled: true,
                      controller: _phoneNumberController,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        final PhoneContact contact =
                            await FlutterContactPicker.pickPhoneContact();

                        if (contact.phoneNumber == null) return;

                        _phoneNumberController.text =
                            ContactFormat().contact(contact).toString();

                        FocusScope.of(context).unfocus();

                        setState(() {
                          _selectedNetwork = NetworkHelper()
                              .getNetworkId(
                                  beneficiary: _phoneNumberController.text)
                              .toString();
                        });
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    child: Text(
                      "Choose Contact",
                      style: theme.textTheme.small,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ZeelButton(
                    text: "Buy",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ConfirmTransaction(
                              onPinComplete: (pin) async {
                                await buyAirtime(
                                  context: context,
                                  phoneNumber: _phoneNumberController.text,
                                  pin: pin!,
                                  ref: ref,
                                  amount: int.parse(_amountController.text),
                                  network: _selectedNetwork,
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
