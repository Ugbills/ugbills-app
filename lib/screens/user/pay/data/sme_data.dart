// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/controllers/bills/sme_data_controller.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/number_formarter.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/models/api/sme_data_model.dart';
import 'package:ugbills/providers/sme_data_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/widgets/widgets.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';

class SMEDataBills extends ConsumerStatefulWidget {
  const SMEDataBills({super.key});

  @override
  ConsumerState<SMEDataBills> createState() => _SMEDataBillsState();
}

class _SMEDataBillsState extends ConsumerState<SMEDataBills> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _planController = TextEditingController();
  final TextEditingController _packageIdController = TextEditingController();
  SMEDataProduct? _selectedProduct;
  var formKey = GlobalKey<FormState>();

  // Network icon mapping helper
  String getNetworkIcon(String networkName) {
    switch (networkName.toLowerCase()) {
      case 'mtn':
      case 'mtn sme':
        return ZeelPng.mtn;
      case 'airtel':
      case 'airtel sme':
        return ZeelPng.airtel;
      case 'glo':
      case 'glo sme':
        return ZeelPng.glo;
      case '9mobile':
      case 'etisalat':
        return ZeelPng.mobile;
      default:
        return ZeelPng.mtn;
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(fetchMobileUserInformationProvider);
    var smeData = ref.watch(fetchSMEDataProvider);
    var theme = ShadTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('SME Data'),
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
              smeData.when(
                data: (products) => SizedBox(
                  height: 80,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final product = products![index];
                        return ZeelNetwork(
                          icon: getNetworkIcon(product.name ?? ''),
                          selected: _selectedProduct?.code == product.code,
                          onTap: () {
                            setState(() {
                              _selectedProduct = product;
                              _planController.clear();
                              _packageIdController.clear();
                              _amountController.clear();
                            });
                          },
                        );
                      },
                      itemCount: products?.length ?? 0),
                ),
                loading: () => const SizedBox(
                  height: 80,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => SizedBox(
                  height: 80,
                  child: Center(
                    child: Text('Error loading networks: $error'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ZeelTextFieldTitle(text: "Select Data Plan"),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZeelSelectTextField(
                      hint: "Choose a Plan",
                      validator: packageValidator,
                      controller: _planController,
                      onTap: () {
                        if (_selectedProduct == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a network first'),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            _createRoute(SMEDataPackagesWidget(
                                _selectedProduct!,
                                _planController,
                                _packageIdController,
                                _amountController)),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const ZeelTextFieldTitle(text: "Phone Number"),
                    ZeelTextField(
                        hint: "Enter Phone Number",
                        maxLength: 11,
                        validator: phoneNumberValidator,
                        enabled: true,
                        controller: _phoneNumberController),
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
              const SizedBox(
                height: 10,
              ),
              const ZeelTextFieldTitle(text: "Amount"),
              ZeelTextField(
                hint: "NGN1000",
                enabled: false,
                controller: _amountController,
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
                height: 20,
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
                                await ref
                                    .read(sMEDataControllerProvider.notifier)
                                    .buy(
                                      context: context,
                                      phoneNumber: _phoneNumberController.text,
                                      planId: _packageIdController.text,
                                      dataPlan: _planController.text,
                                      amount: _amountController.text,
                                      pin: pin!,
                                      ref: ref,
                                      network: _selectedProduct!.code!,
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

class SMEDataPackagesWidget extends ConsumerWidget {
  final SMEDataProduct product;
  final TextEditingController packageController;
  final TextEditingController packageIdController;
  final TextEditingController amountController;
  const SMEDataPackagesWidget(this.product, this.packageController,
      this.packageIdController, this.amountController,
      {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('${product.name} Plans'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 24),
        child: product.variations?.isEmpty ?? true
            ? const Center(
                child: Text('No plans available for this network'),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: product.variations?.length ?? 0,
                itemBuilder: (context, index) {
                  final variation = product.variations![index];
                  if (variation.visible != true) return const SizedBox.shrink();

                  return ListTile(
                    onTap: () {
                      packageController.text = variation.name ?? '';
                      packageIdController.text = variation.code ?? '';
                      amountController.text = "NGN${variation.price}";
                      Go.back();
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          variation.name ?? 'Unknown Plan',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          "₦${returnAmount(variation.price)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                    trailing: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        height: 30,
                        width: 30,
                        child: (packageIdController.text == variation.code)
                            ? const Icon(Icons.check)
                            : null),
                  );
                }),
      ),
    );
  }
}

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
