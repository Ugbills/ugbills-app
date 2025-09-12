import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/widgets/beneficiary_widget.dart';

import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/themes/palette.dart';

class SavedBeneficiaries extends ConsumerStatefulWidget {
  const SavedBeneficiaries({super.key});

  @override
  ConsumerState<SavedBeneficiaries> createState() => _SavedBeneficiariesState();
}

class _SavedBeneficiariesState extends ConsumerState<SavedBeneficiaries> {
  var searchWord = "";
  @override
  Widget build(BuildContext context) {
    var beneficiaries = ref.watch(fetchUserBeneficiariesProvider);
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
              onChanged: (value) {
                setState(() {
                  searchWord = value;
                });
              },
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
            beneficiaries.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text(error.toString()),
                data: (data) => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: searchWord.isEmpty
                        ? data!.data!.length
                        : data!.data!
                            .where((element) =>
                                element.accountName!.contains(searchWord))
                            .length,
                    itemBuilder: (context, index) {
                      return BeneficiaryTile(
                        name: data.data![index].accountName!,
                        bank: data.data![index].bankName!,
                        accountNumber: data.data![index].accountNumber!,
                        sessionId: data.data![index].sessionId!,
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
