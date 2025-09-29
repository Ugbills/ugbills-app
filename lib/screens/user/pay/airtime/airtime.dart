// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/controllers/bills/airtime_controller.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/network_helper.dart';
import 'package:ugbills/helpers/common/number_formarter.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/models/api/mobile_airtime_model.dart';
import 'package:ugbills/models/api/networks_model.dart' as NetworksAPI;
import 'package:ugbills/providers/mobile_airtime_provider.dart';
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
  MobileAirtimeProduct? _selectedProvider;

  var formKey = GlobalKey<FormState>();

  // Hardcoded networks list matching NetworksModel structure
  final NetworksAPI.NetworksModel hardcodedNetworks = NetworksAPI.NetworksModel(
    code: 200,
    success: true,
    message: "Networks retrieved successfully",
    data: [
      NetworksAPI.Data(
        id: "1",
        name: "MTN",
        icon: ZeelPng.mtn,
        swapNumber: "0803",
        swapPercent: 95,
      ),
      NetworksAPI.Data(
        id: "2",
        name: "Airtel",
        icon: ZeelPng.airtel,
        swapNumber: "0701",
        swapPercent: 90,
      ),
      NetworksAPI.Data(
        id: "3",
        name: "Glo",
        icon: ZeelPng.glo,
        swapNumber: "0705",
        swapPercent: 85,
      ),
      NetworksAPI.Data(
        id: "4",
        name: "9mobile",
        icon: ZeelPng.mobile,
        swapNumber: "0809",
        swapPercent: 80,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(fetchMobileUserInformationProvider);
    var mobileProviders = ref.watch(fetchMobileAirtimeProvidersProvider);
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
          child: mobileProviders.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading providers: $error'),
                  ElevatedButton(
                    onPressed: () =>
                        ref.refresh(fetchMobileAirtimeProvidersProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            data: (providers) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ZeelTextFieldTitle(text: "Select Network Provider"),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final provider = providers![index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedProvider = provider;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _selectedProvider?.code == provider.code
                                    ? theme.colorScheme.primary
                                    : Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                provider.image != null
                                    ? Image.network(
                                        provider.image!,
                                        height: 32,
                                        width: 32,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.network_cell,
                                                    size: 32),
                                      )
                                    : const Icon(Icons.network_cell, size: 32),
                                const SizedBox(height: 4),
                                Text(
                                  provider.name ?? 'Network',
                                  style: theme.textTheme.small,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: providers?.length ?? 0),
                ),
                const SizedBox(height: 10),
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
                      const SizedBox(height: 3),
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
                      const SizedBox(height: 5),
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

                          // Auto-select provider based on phone number if possible
                          final providers = ref
                              .read(fetchMobileAirtimeProvidersProvider)
                              .value;
                          if (providers != null && providers.isNotEmpty) {
                            final networkId = NetworkHelper()
                                .getNetworkId(
                                    beneficiary: _phoneNumberController.text)
                                .toString();

                            // Try to find matching provider
                            final matchingProvider = providers.firstWhere(
                              (provider) =>
                                  provider.code?.toLowerCase() ==
                                  networkId.toLowerCase(),
                              orElse: () => providers.first,
                            );

                            setState(() {
                              _selectedProvider = matchingProvider;
                            });
                          }
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
                          if (_selectedProvider == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please select a network first')),
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ConfirmTransaction(
                                onPinComplete: (pin) async {
                                  await ref
                                      .read(airtimeControllerProvider.notifier)
                                      .buy(
                                        context: context,
                                        phoneNumber:
                                            _phoneNumberController.text,
                                        pin: pin!,
                                        ref: ref,
                                        amount:
                                            double.parse(_amountController.text)
                                                .toInt(),
                                        network: _selectedProvider!.code!,
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
        ),
      )),
    );
  }
}
