import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zeelpay/screens/user/send/bank/bank.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({super.key});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  final List banks = [
    ["assets/svgs/access-bank.svg", "UBA"],
    ["assets/svgs/access-bank.svg", "Zenith"],
    ["assets/svgs/access-bank.svg", "Access"],
    ["assets/svgs/access-bank.svg", "Kuda"],
    ["assets/svgs/access-bank.svg", "Zappy"],
    ["assets/svgs/access-bank.svg", "Sterling"],
    ["assets/svgs/access-bank.svg", "Diamond"],
  ];

  int _selectedValue = 1;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Bank'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 24),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  hintText: "Search a bank",
                  suffixIcon: const Icon(Icons.search_rounded),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: ZealPalette.darkerGrey,
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: banks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BankTransfer()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/images/access-bank.png"),
                          const SizedBox(width: 6),
                          Text(banks[index][1]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void _handleRadioValueChange(int value) {
//   setState(() {
//     _selectedValue = value;
//   });
// }

// Widget _bankTile(
//     String imagePath, String bankName, Function(bool?)? onChanged) {
//   return RadioListTile<int>(
//     title: const Text('Option 1'),
//     value: 1,
//     groupValue: 1,
//     onChanged: ,
//   );
// }
