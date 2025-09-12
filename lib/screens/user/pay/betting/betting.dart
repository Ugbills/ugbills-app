import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/controllers/bills/betting_controller.dart';
import 'package:ugbills/providers/betting_provider.dart';
import 'package:ugbills/screens/user/pay/betting/betting_transaction_details.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';

class BettingBills extends ConsumerStatefulWidget {
  const BettingBills({super.key});

  @override
  ConsumerState<BettingBills> createState() => _BettingBillsState();
}

class _BettingBillsState extends ConsumerState<BettingBills> {
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _providerIdController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Betting'),
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
              const ZeelTextFieldTitle(text: "Select Provider"),
              ZeelSelectTextField(
                hint: "Select Provider",
                controller: _providerController,
                onTap: () {
                  Navigator.push(
                      context,
                      _createRoute(BettingProvidersWidget(
                          _providerController, _providerIdController)));
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const ZeelTextFieldTitle(text: "User ID"),
              ZeelTextField(
                  hint: "Enter your betting id",
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                    setState(() {});
                  },
                  enabled: true,
                  controller: _userIdController),
              const SizedBox(
                height: 5,
              ),
              const ZeelTextFieldTitle(text: "Amount"),
              ZeelTextField(
                  hint: "NGN1000",
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    setState(() {});
                  },
                  enabled: true,
                  controller: _amountController),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ZeelButton(
                    text: "Fund",
                    onPressed: _providerIdController.text.isNotEmpty &&
                            _userIdController.text.isNotEmpty
                        ? () {
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
                                      showDetails("Provider Name",
                                          _providerController.text, context),
                                      showDetails("User ID",
                                          _userIdController.text, context),
                                      showDetails("Fee", "₦10.00", context),
                                      const SizedBox(height: 24),
                                      ZeelButton(
                                        text: "Confirm",
                                        onPressed: () {
                                          Go.to(ConfirmTransaction(
                                              onPinComplete: (pin) {
                                            ref
                                                .read(bettingControllerProvider
                                                    .notifier)
                                                .buy(
                                                    customerId:
                                                        _userIdController.text,
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
                        : null,
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

class BettingProvidersWidget extends ConsumerWidget {
  final TextEditingController providerController;
  final TextEditingController providerIdController;
  const BettingProvidersWidget(
      this.providerController, this.providerIdController,
      {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var providers = ref.watch(fetchBettingProvidersProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Bills & Packages'),
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
                          plans.data![index].name!.toUpperCase();
                      providerIdController.text = plans.data![index].productId!;
                      Go.back();
                    },
                    title: Text(plans.data![index].name!.toUpperCase()),
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
