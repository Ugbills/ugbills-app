import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/controllers/card/card_controller.dart';
import 'package:zeelpay/providers/card_provider.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/user/card/modal.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class CreateCardScreen extends ConsumerWidget {
  const CreateCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cardStatus = ref.watch(canCreateCardProvider);
    var isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              ShadImage(
                ZeelPng.card,
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20.0),
              Text(
                "Make Payments Anywhere Online",
                style: ShadTheme.of(context)
                    .textTheme
                    .h1
                    .copyWith(color: ShadTheme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              const Text(
                "A virtual card that makes life easier, pay for anything online with your card",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: cardStatus.when(
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => Text("Error: $error"),
                      data: (status) => ZeelButton(
                        isLoading: isLoading,
                        text: status! ? "Create" : "Apply",
                        onPressed: () async {
                          if (status) {
                            CardModal.showModal(context);
                          } else {
                            await applyForCard(context: context, ref: ref);
                          }
                        },
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
