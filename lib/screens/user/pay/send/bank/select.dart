import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugbills/providers/bank_provider.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class SelectBank extends ConsumerStatefulWidget {
  final AutoDisposeStateProvider bankNameProvider;
  final AutoDisposeStateProvider bankCodeProvider;
  const SelectBank(this.bankNameProvider, this.bankCodeProvider, {super.key});

  @override
  ConsumerState<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends ConsumerState<SelectBank> {
  var _searchedWord = '';

  List searchedList = [];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var banks = ref.watch(fetchBanksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Bank'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 24),
        child: banks.when(
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            data: (bank) => Column(
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchedWord = value;

                          searchedList = bank!.data!
                              .where((element) => element.bankName!
                                  .toLowerCase()
                                  .startsWith(value.toLowerCase()))
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Search a bank",
                          suffixIcon: const Icon(Icons.search_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: ZealPalette.darkerGrey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: ZealPalette.darkerGrey,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: bank!.data!
                          .where((element) => element.bankName!
                              .toLowerCase()
                              .contains(_searchedWord.toLowerCase()))
                          .length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ref.read(widget.bankNameProvider.notifier).state =
                                bank.data!
                                    .where((element) => element.bankName!
                                        .toLowerCase()
                                        .contains(_searchedWord.toLowerCase()))
                                    .toList()[index]
                                    .bankName;
                            ref.read(widget.bankCodeProvider.notifier).state =
                                bank.data!
                                    .where((element) => element.bankName!
                                        .toLowerCase()
                                        .contains(_searchedWord.toLowerCase()))
                                    .toList()[index]
                                    .bankCode;
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? ZealPalette.lighterBlack
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              bank.data!
                                  .where((element) => element.bankName!
                                      .toLowerCase()
                                      .contains(_searchedWord.toLowerCase()))
                                  .toList()[index]
                                  .bankName!,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                )),
      ),
    );
  }
}
