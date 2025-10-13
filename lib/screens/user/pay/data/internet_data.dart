// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/controllers/bills/internet_data_controller.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/helpers/common/number_formarter.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/models/api/internet_data_model.dart';
import 'package:ugbills/providers/internet_data_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';

class InternetDataBills extends ConsumerStatefulWidget {
  const InternetDataBills({super.key});

  @override
  ConsumerState<InternetDataBills> createState() => _InternetDataBillsState();
}

class _InternetDataBillsState extends ConsumerState<InternetDataBills> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _planController = TextEditingController();
  final TextEditingController _packageIdController = TextEditingController();
  InternetDataProduct? _selectedProduct;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(fetchMobileUserInformationProvider);
    var internetData = ref.watch(fetchInternetDataProvider);
    var theme = ShadTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Internet Data'),
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
              internetData.when(
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
                        return InternetProviderWidget(
                          product: product,
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
                            _createRoute(InternetDataPackagesWidget(
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
                                    .read(
                                        internetDataControllerProvider.notifier)
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

class InternetDataPackagesWidget extends ConsumerWidget {
  final InternetDataProduct product;
  final TextEditingController packageController;
  final TextEditingController packageIdController;
  final TextEditingController amountController;
  const InternetDataPackagesWidget(this.product, this.packageController,
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

class InternetProviderWidget extends StatelessWidget {
  final InternetDataProduct product;
  final bool selected;
  final VoidCallback onTap;

  const InternetProviderWidget({
    super.key,
    required this.product,
    required this.selected,
    required this.onTap,
  });

  String getNetworkIcon(String networkName) {
    switch (networkName.toLowerCase()) {
      case 'spectranet':
        return ZeelPng.mtn; // Fallback for now
      case 'swift':
      case 'swift networks':
        return ZeelPng.airtel;
      case 'smile':
      case 'smile communications':
        return ZeelPng.glo;
      case 'ipnx':
        return ZeelPng.mobile;
      case 'mtn':
      case 'mtn internet':
        return ZeelPng.mtn;
      case 'airtel':
      case 'airtel internet':
        return ZeelPng.airtel;
      case 'glo':
      case 'glo internet':
        return ZeelPng.glo;
      case '9mobile':
      case 'etisalat':
        return ZeelPng.mobile;
      default:
        return ZeelPng.mtn; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: ShadImage(product.image!.isEmpty
                  ? getNetworkIcon(product.name!)
                  : product.image!),
            ),
          ),
          if (selected)
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
