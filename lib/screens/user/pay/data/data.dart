// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/controllers/bills/data_controller.dart';
import 'package:zeelpay/helpers/common/amount_formatter.dart';
import 'package:zeelpay/helpers/common/number_formarter.dart';
import 'package:zeelpay/helpers/forms/validators.dart';
import 'package:zeelpay/providers/network_provider.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/user/widgets/widgets.dart';
import 'package:zeelpay/screens/widgets/authenticate_transaction.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class DataBills extends ConsumerStatefulWidget {
  const DataBills({super.key});

  @override
  ConsumerState<DataBills> createState() => _DataBillsState();
}

class _DataBillsState extends ConsumerState<DataBills> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _planController = TextEditingController();
  final TextEditingController _packageIdController = TextEditingController();
  var _selectedNetwork = "";
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var networks = ref.watch(getNetworksProvider);
    var user = ref.watch(fetchUserInformationProvider);
    var theme = ShadTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Buy Data'),
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
                        if (_selectedNetwork.isEmpty) {
                        } else {
                          Navigator.push(
                            context,
                            _createRoute(BillsPackagesWidget(
                                _selectedNetwork,
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
                                await buyData(
                                  context: context,
                                  planId: _packageIdController.text,
                                  dataPlan: _planController.text,
                                  phoneNumber: _phoneNumberController.text,
                                  pin: pin!,
                                  ref: ref,
                                  amount: _amountController.text,
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

class BillsPackagesWidget extends ConsumerWidget {
  final String networkId;
  final TextEditingController packageController;
  final TextEditingController packageIdController;
  final TextEditingController amountController;
  const BillsPackagesWidget(this.networkId, this.packageController,
      this.packageIdController, this.amountController,
      {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var plans = ref.watch(getDataPlansProvider(networkId: networkId));
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Bills & Packages'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 24),
        child: plans.when(
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            data: (plans) => ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: plans!.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      packageController.text = plans.data![index].plan!;
                      packageIdController.text = plans.data![index].id!;
                      amountController.text = "NGN${plans.data![index].cost}";
                      Go.back();
                    },
                    title: Text(plans.data![index].plan!),
                    trailing: Text("₦${plans.data![index].cost}"),
                  );
                })),
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
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
