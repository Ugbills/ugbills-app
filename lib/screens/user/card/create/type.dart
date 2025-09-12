import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/controllers/card/card_controller.dart';
import 'package:ugbills/helpers/common/amount_formatter.dart';
import 'package:ugbills/providers/card_provider.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

import '../../../../models/api/card_type_model.dart';

class CardType extends ConsumerStatefulWidget {
  const CardType({super.key});

  @override
  ConsumerState<CardType> createState() => _CardTypeState();
}

class _CardTypeState extends ConsumerState<CardType> {
  String? selectedCardType;
  dynamic amount;
  String? selectId;

  @override
  Widget build(BuildContext context) {
    var cardType = ref.watch(getCardTypesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Type'),
        leading: const ZeelBackButton(),
        leadingWidth: 100,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: cardType.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text(error.toString())),
              data: (items) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Card Type"),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Select an option'),
                          value: selectedCardType,
                          underline: Container(color: Colors.transparent),
                          items: items!.data!.map((Data value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Text(value.name!.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCardType = newValue;
                              amount = items.data!
                                  .firstWhere(
                                      (element) => element.name == newValue)
                                  .creationFee;
                              selectId = items.data!
                                  .firstWhere(
                                      (element) => element.name == newValue)
                                  .id;
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      _feeContainer(amount ?? 0),
                      const Spacer(),
                      ZeelButton(
                        onPressed: () {
                          Go.to(ConfirmTransaction(
                            onPinComplete: (pin) async {
                              await createCard(
                                  context: context,
                                  cardType: selectId!,
                                  pin: pin!,
                                  ref: ref);
                            },
                          ));
                        },
                        text: "Pay",
                      ),
                    ],
                  )),
        ),
      ),
    );
  }

  Widget _feeContainer(dynamic amount) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Card Creation Fee"),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
            color: isDark ? ZealPalette.lighterBlack : Colors.grey.shade300,
          ),
          child: Text("\$${returnAmount(amount)}"),
        ),
      ],
    );
  }
}
