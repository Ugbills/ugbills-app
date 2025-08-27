import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/controllers/bills/tv_controller.dart';
import 'package:zeelpay/providers/cable_provider.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/widgets/authenticate_transaction.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class TVBills extends ConsumerStatefulWidget {
  const TVBills({super.key});

  @override
  ConsumerState<TVBills> createState() => _TVBillsState();
}

class _TVBillsState extends ConsumerState<TVBills> {
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _packageIdController = TextEditingController();
  final TextEditingController _planIdController = TextEditingController();
  final TextEditingController _smartCardController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  var plans = [];
  @override
  Widget build(BuildContext context) {
    var cables = ref.watch(fetchTvProvidersProvider);
    var packageController = ref.watch(packageNameProvider);
    var customerNameController = ref.watch(customerNameProvider);
    var isValidating = ref.watch(isValidatingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV'),
        leadingWidth: 100,
        forceMaterialTransparency: true,
        leading: const ZeelBackButton(),
      ),
      body: ZeelScrollable(
          hasScrollBody: false,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: cables.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: ZeelText(
                    text: error.toString(),
                    center: TextAlign.center,
                  ),
                ),
                data: (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ZeelTextFieldTitle(text: "Select Provider"),
                    ZeelSelectTextField(
                      hint: "Select Provider",
                      controller: _providerController,
                      onTap: () {
                        //show bottom sheet where user can select the cable provider

                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ListTile(
                                      title: Text(
                                        data[index].toString().capitalize,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onTap: () {
                                        _providerController.text =
                                            data[index].toString().capitalize;
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const ZeelTextFieldTitle(text: "Package"),
                    ZeelSelectTextField(
                      hint: packageController,
                      onTap: () => {
                        if (_providerController.text.isEmpty)
                          {}
                        else
                          {
                            Navigator.push(
                              context,
                              _createRoute(BillsPackagesWidget(
                                  _providerController.text,
                                  packageNameProvider,
                                  _packageIdController,
                                  _planIdController,
                                  _amountController)),
                            )
                          }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    packageController.isEmpty
                        ? const SizedBox.shrink()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ZeelTextFieldTitle(
                                  text: "Smartcard Number"),
                              ZeelTextField(
                                hint: "Enter your smartcard number",
                                onEditingComplete: () async {
                                  FocusScope.of(context).unfocus();
                                  await ref
                                      .read(tvControllerProvider.notifier)
                                      .validateName(
                                        customerId: _smartCardController.text,
                                        productID: _packageIdController.text,
                                        ref: ref,
                                      )
                                      .then((value) {
                                    if (value != null) {
                                      ref
                                          .read(customerNameProvider.notifier)
                                          .state = value.name!;
                                    }
                                  });
                                },
                                enabled: true,
                                controller: _smartCardController,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              isValidating
                                  ? const CircularProgressIndicator()
                                  : customerNameController.isEmpty
                                      ? const SizedBox.shrink()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const ZeelTextFieldTitle(
                                                text: "Customer Name"),
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
                                hint: "",
                                enabled: false,
                                controller: _amountController,
                              ),
                            ],
                          ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ZeelButton(
                          text: customerNameController.isEmpty
                              ? "Validate"
                              : "Pay",
                          onPressed: _packageIdController.text.isNotEmpty &&
                                  _smartCardController.text.isNotEmpty
                              ? () {
                                  if (customerNameController.isEmpty) {
                                    if (_smartCardController.text.isEmpty) {
                                      return;
                                    } else {
                                      ref
                                          .read(tvControllerProvider.notifier)
                                          .validateName(
                                            customerId:
                                                _smartCardController.text,
                                            productID:
                                                _packageIdController.text,
                                            ref: ref,
                                          )
                                          .then((value) {
                                        if (value != null) {
                                          ref
                                              .read(
                                                  customerNameProvider.notifier)
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Confirm Details",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  IconButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      icon: Image.asset(
                                                          "assets/images/x.png")),
                                                ],
                                              ),
                                              showDetails(
                                                  "Amount",
                                                  _amountController.text,
                                                  context),
                                              showDetails(
                                                  "Cable Name",
                                                  _providerController.text,
                                                  context),
                                              showDetails(
                                                  "Smartcard Number",
                                                  _smartCardController.text,
                                                  context),
                                              showDetails(
                                                  "Customer Name",
                                                  customerNameController,
                                                  context),
                                              showDetails(
                                                  "Fee", "₦10.00", context),
                                              const SizedBox(height: 24),
                                              ZeelButton(
                                                text: "Confirm",
                                                onPressed: () {
                                                  Go.to(ConfirmTransaction(
                                                      onPinComplete: (pin) {
                                                    ref
                                                        .read(
                                                            tvControllerProvider
                                                                .notifier)
                                                        .buy(
                                                            customerId:
                                                                _smartCardController
                                                                    .text,
                                                            productID:
                                                                _packageIdController
                                                                    .text,
                                                            planId:
                                                                _planIdController
                                                                    .text,
                                                            pin: pin!,
                                                            context: context,
                                                            cableName:
                                                                _providerController
                                                                    .text,
                                                            amount:
                                                                _amountController
                                                                    .text,
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
              ),
            ),
          )),
    );
  }
}

final packageNameProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

final customerNameProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

class BillsPackagesWidget extends ConsumerWidget {
  final String cableName;
  final AutoDisposeStateProvider<String> packageController;
  final TextEditingController packageIdController;
  final TextEditingController planIdController;
  final TextEditingController amountController;
  const BillsPackagesWidget(this.cableName, this.packageController,
      this.packageIdController, this.planIdController, this.amountController,
      {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var plans = ref.watch(fetchTvPackagesProvider(cableName: cableName));
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
                      ref.read(packageController.notifier).state =
                          plans.data![index].planName!;
                      packageIdController.text = plans.data![index].productId!;
                      amountController.text = "NGN${plans.data![index].amount}";
                      planIdController.text = plans.data![index].planId!;
                      Go.back();
                    },
                    title: Text(plans.data![index].planName!),
                    trailing: Text("₦${plans.data![index].amount}"),
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

Widget showDetails(String lead, String trail, BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lead,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        Text(
          trail,
          style: TextStyle(
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade900,
          ),
        ),
      ],
    ),
  );
}
