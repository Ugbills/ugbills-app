import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zeelpay/controllers/wallet/wallet_controller.dart';
import 'package:zeelpay/helpers/forms/validators.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CouponCode extends HookConsumerWidget {
  CouponCode({super.key});

  final TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final pendingRedeem = useState<Future<void>?>(null);
    final isLoading = useFuture(pendingRedeem.value).connectionState ==
        ConnectionState.waiting;

    return Scaffold(
      appBar: AppBar(
          leadingWidth: 100,
          forceMaterialTransparency: true,
          title: const Text("Coupon Code"),
          leading: const ZeelBackButton()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const ZeelTextFieldTitle(text: "Code"),
              Form(
                key: formKey,
                child: ZeelTextField(
                  hint: "enter coupon code",
                  controller: codeController,
                  validator: couponValidator,
                  enabled: true,
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: ZeelButton(
                  isLoading: isLoading,
                  text: "Confirm Deposit",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final future = ref
                          .read(walletControllerProvider.notifier)
                          .redeemCoupon(
                              code: codeController.text, context: context);

                      pendingRedeem.value = future;
                    }
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
