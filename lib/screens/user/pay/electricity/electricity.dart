import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/controllers/bills/electricity_controller.dart';
import 'package:ugbills/providers/electricity_provider.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/user/pay/electricity/electricity_transaction_details.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';

class ElectricityBills extends ConsumerStatefulWidget {
  const ElectricityBills({super.key});

  @override
  ConsumerState<ElectricityBills> createState() => _ElectricityBillsState();
}

class _ElectricityBillsState extends ConsumerState<ElectricityBills> {
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _providerIdController = TextEditingController();
  final TextEditingController _meterNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var isValidating = ref.watch(isValidatingProvider);
    var customerNameController = ref.watch(customerNameProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Electricity'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: ZeelScrollable(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ZeelTextFieldTitle(text: "Select Provider"),
            ZeelSelectTextField(
                onTap: () => Navigator.push(
                    context,
                    _createRoute(ElectricityProvidersWidget(
                        _providerController, _providerIdController))),
                hint: "Select Provider",
                controller: _providerController),
            const SizedBox(
              height: 5,
            ),
            const ZeelTextFieldTitle(text: "Type"),
            ZeelSelectTextField(
              hint: "Select Meter Type",
              controller: _typeController,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Wrap(
                        children: [
                          ListTile(
                            title: const Text("Prepaid"),
                            onTap: () {
                              _typeController.text = "Prepaid";
                              Go.back();
                            },
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("Postpaid"),
                            onTap: () {
                              _typeController.text = "Postpaid";
                              Go.back();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            const ZeelTextFieldTitle(text: "Meter Number"),
            ZeelTextField(
                hint: "Enter your meter number",
                onEditingComplete: () async {
                  FocusScope.of(context).unfocus();
                  await ref
                      .read(electricityControllerProvider.notifier)
                      .validateName(
                        customerId: _meterNumberController.text,
                        productID: _providerIdController.text,
                        meterType: _typeController.text.toLowerCase(),
                        ref: ref,
                      )
                      .then((value) {
                    if (value != null) {
                      ref.read(customerNameProvider.notifier).state =
                          value.name!;
                    }
                  });
                },
                enabled: true,
                controller: _meterNumberController),
            const SizedBox(
              height: 5,
            ),
            isValidating
                ? const CircularProgressIndicator()
                : customerNameController.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ZeelTextFieldTitle(text: "Customer Name"),
                          ZeelTextField(
                            hint: customerNameController,
                            enabled: false,
                          ),
                        ],
                      ),
            const SizedBox(
              height: 5,
            ),
            const ZeelTextFieldTitle(text: "Amount"),
            ZeelTextField(
                hint: "NGN1000", enabled: true, controller: _amountController),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ZeelButton(
                  text: customerNameController.isEmpty ? "Validate" : "Pay",
                  onPressed: _providerIdController.text.isNotEmpty &&
                          _meterNumberController.text.isNotEmpty
                      ? () {
                          if (customerNameController.isEmpty) {
                            if (_meterNumberController.text.isEmpty) {
                              return;
                            } else {
                              ref
                                  .read(electricityControllerProvider.notifier)
                                  .validateName(
                                    customerId: _meterNumberController.text,
                                    productID: _providerIdController.text,
                                    meterType:
                                        _typeController.text.toLowerCase(),
                                    ref: ref,
                                  )
                                  .then((value) {
                                if (value != null) {
                                  ref
                                      .read(customerNameProvider.notifier)
                                      .state = value.name!;
                                }
                              });
                            }
                          } else {
                            showModalBottomSheet(
                                scrollControlDisabledMaxHeightRatio:
                                    double.maxFinite,
                                context: context,
                                builder: (_) => Container(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Confirm Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                          IconButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              icon: Image.asset(
                                                  "assets/images/x.png")),
                                        ],
                                      ),
                                      showDetails("Amount",
                                          _amountController.text, context),
                                      showDetails("Disco Name",
                                          _providerController.text, context),
                                      showDetails("Meter Number",
                                          _meterNumberController.text, context),
                                      showDetails("Customer Name",
                                          customerNameController, context),
                                      showDetails("Fee", "₦10.00", context),
                                      const SizedBox(height: 24),
                                      ZeelButton(
                                        text: "Confirm",
                                        onPressed: () {
                                          Go.to(ConfirmTransaction(
                                              onPinComplete: (pin) {
                                            ref
                                                .read(
                                                    electricityControllerProvider
                                                        .notifier)
                                                .buy(
                                                    meterType:
                                                        _typeController.text,
                                                    customerId:
                                                        _meterNumberController
                                                            .text,
                                                    productID:
                                                        _providerIdController
                                                            .text,
                                                    pin: pin!,
                                                    context: context,
                                                    amount:
                                                        _amountController.text,
                                                    ref: ref);
                                          }));
                                        },
                                      )
                                    ])));
                          }
                        }
                      : null,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class ElectricityProvidersWidget extends ConsumerWidget {
  final TextEditingController providerController;
  final TextEditingController providerIdController;
  const ElectricityProvidersWidget(
      this.providerController, this.providerIdController,
      {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var providers = ref.watch(fetchElectricityProviderProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Providers'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 24),
        child: providers.when(
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
                      providerController.text =
                          plans.data![index].disco!.toUpperCase();
                      providerIdController.text = plans.data![index].productId!;
                      Go.back();
                    },
                    title: Text(plans.data![index].disco!.toUpperCase()),
                    trailing: Text(
                      "₦${plans.data![index].minAmount} - ₦${plans.data![index].maxAmount}",
                      overflow: TextOverflow.clip,
                    ),
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

final customerNameProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});
