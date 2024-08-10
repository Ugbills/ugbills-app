import 'package:flutter/material.dart';
import 'package:zeelpay/models/beneficiaries.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class SavedBeneficiaries extends StatefulWidget {
  const SavedBeneficiaries({super.key});

  static List<BeneficiariesModel> listOfBeneficiaries = [
    BeneficiariesModel(
      name: "Yinka Adeola",
      bank: "First bank",
      accountNumber: "568498592552",
    ),
    BeneficiariesModel(
      name: "Tamuno Adeola",
      bank: "GTB bank",
      accountNumber: "568498592552",
    ),
    BeneficiariesModel(
      name: "Ola Adeola",
      bank: "Zenith bank",
      accountNumber: "568498592552",
    ),
  ];

  @override
  State<SavedBeneficiaries> createState() => _SavedBeneficiariesState();
}

class _SavedBeneficiariesState extends State<SavedBeneficiaries> {
  List<BeneficiariesModel> displayList =
      List.from(SavedBeneficiaries.listOfBeneficiaries);

  void updateList(String value) {
    setState(() {
      displayList = SavedBeneficiaries.listOfBeneficiaries
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ZeelTextFieldTitle(text: "Saved Beneficiaries"),
                //close button
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ZealPalette.darkerGrey,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: ZealPalette.darkerGrey),
                ),
                hintText: "Search  beneficiary",
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  return beneficiary(
                    displayList[index].name!,
                    displayList[index].bank!,
                    displayList[index].accountNumber!,
                    context,
                  );
                })
          ],
        ),
      ),
    );
  }
}

Widget beneficiary(
    String name, String bank, String accountNumber, BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: isDark ? ZealPalette.lighterBlack : Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset("assets/images/access-bank.png"),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Text(
                  bank,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(
                  accountNumber,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
