import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/providers/card_provider.dart';
import 'package:ugbills/screens/user/card/available.dart';
import 'package:ugbills/screens/user/card/create/create.dart';

class CardScreen extends ConsumerWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cardStatus = ref.watch(canCreateCardProvider);
    return cardStatus.when(
      loading: () =>
          const SafeArea(child: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Text("Error: $error"),
      data: (status) {
        return status! ? const AvailableCards() : const CreateCardScreen();
      },
    );
  }
}
