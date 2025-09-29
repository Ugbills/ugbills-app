import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/controllers/bills/tv_controller.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/models/api/mobile_cable_model.dart';
import 'package:ugbills/providers/cable_provider.dart';
import 'package:ugbills/providers/mobile_cable_provider.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';

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
  MobileCableProduct? _selectedProvider;
  // MobileCableVariation? _selectedVariation; // Will be used for future features
  var plans = [];
  @override
  Widget build(BuildContext context) {
    var cables = ref.watch(fetchMobileCableProvidersProvider);
    var packageController = ref.watch(packageNameProvider);
    var customerNameController = ref.watch(customerNameProvider);
    var isValidating = ref.watch(isValidatingProvider);
    var isLoading = ref.watch(isLoadingProvider);
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
                    text: stackTrace.toString(),
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
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  final provider = data[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ListTile(
                                      title: Text(
                                        provider.name ?? 'Unknown Provider',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        provider.code ?? '',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _selectedProvider = provider;
                                          _providerController.text =
                                              provider.name ?? '';
                                          _packageIdController.clear();
                                          _amountController.clear();
                                          ref
                                              .read(
                                                  packageNameProvider.notifier)
                                              .state = '';
                                          ref
                                              .read(
                                                  customerNameProvider.notifier)
                                              .state = '';
                                        });
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
                      hint: packageController.isEmpty
                          ? "Select Package"
                          : packageController,
                      onTap: () {
                        if (_selectedProvider == null ||
                            _selectedProvider!.variations == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please select a provider first')),
                          );
                          return;
                        }

                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: [
                                  Text(
                                    'Select ${_selectedProvider!.name} Package',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                      itemCount:
                                          _selectedProvider!.variations!.length,
                                      itemBuilder: (context, index) {
                                        final variation = _selectedProvider!
                                            .variations![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: ListTile(
                                            title: Text(
                                              variation.name ??
                                                  'Unknown Package',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '₦${returnAmount(variation.price)}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                _packageIdController.text =
                                                    variation.code ?? '';
                                                _amountController.text =
                                                    variation.price.toString();
                                                ref
                                                        .read(
                                                            packageNameProvider
                                                                .notifier)
                                                        .state =
                                                    variation.name ?? '';
                                                ref
                                                    .read(customerNameProvider
                                                        .notifier)
                                                    .state = '';
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      },
                                    ),
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
                                  if (_selectedProvider != null &&
                                      _smartCardController.text.isNotEmpty) {
                                    try {
                                      ref
                                          .read(isValidatingProvider.notifier)
                                          .state = true;
                                      String? customerName = await ref.read(
                                          validateMobileCableSmartcardProvider(
                                        productCode: _selectedProvider!.code!,
                                        smartcard: _smartCardController.text,
                                      ).future);

                                      if (customerName != null) {
                                        ref
                                            .read(customerNameProvider.notifier)
                                            .state = customerName;
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Could not validate smartcard number')),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    } finally {
                                      ref
                                          .read(isValidatingProvider.notifier)
                                          .state = false;
                                    }
                                  }
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
                                  _smartCardController.text.isNotEmpty &&
                                  _selectedProvider != null
                              ? () {
                                  if (customerNameController.isEmpty) {
                                    if (_smartCardController.text.isEmpty ||
                                        _selectedProvider == null) {
                                      return;
                                    } else {
                                      ref
                                          .read(isValidatingProvider.notifier)
                                          .state = true;
                                      ref
                                          .read(
                                              validateMobileCableSmartcardProvider(
                                        productCode: _selectedProvider!.code!,
                                        smartcard: _smartCardController.text,
                                      ).future)
                                          .then((value) {
                                        if (value != null) {
                                          ref
                                              .read(
                                                  customerNameProvider.notifier)
                                              .state = value;
                                        }
                                      }).catchError((e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text('Error: $e')),
                                        );
                                      }).whenComplete(() {
                                        ref
                                            .read(isValidatingProvider.notifier)
                                            .state = false;
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
                                                isLoading: isLoading,
                                                onPressed: isLoading
                                                    ? null
                                                    : () {
                                                        Go.to(
                                                            ConfirmTransaction(
                                                                onPinComplete:
                                                                    (pin) {
                                                          ref
                                                              .read(tvControllerProvider
                                                                  .notifier)
                                                              .buy(
                                                                  customerId:
                                                                      _smartCardController
                                                                          .text,
                                                                  productID:
                                                                      _selectedProvider!
                                                                          .code!,
                                                                  planId:
                                                                      _planIdController
                                                                          .text,
                                                                  pin: pin!,
                                                                  context: context,
                                                                  cableName:
                                                                      _selectedProvider!
                                                                          .name!,
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
