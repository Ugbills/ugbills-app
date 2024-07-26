import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';

class NairaCardScreen extends StatefulWidget {
  const NairaCardScreen({super.key});

  @override
  State<NairaCardScreen> createState() => _NairaCardScreenState();
}

class _NairaCardScreenState extends State<NairaCardScreen> {
  String? selectedCardType;
  final List<String> items = [
    'Visa',
    'MasterCard',
    'Verve',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
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
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCardType = newValue;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                ),
              ),
              _feeContainer(),
              const Spacer(),
              ZeelButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Pay",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _feeContainer() {
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
          color: Colors.grey.shade300,
        ),
        child: const Text("₦1,000.00"),
      ),
    ],
  );
}
