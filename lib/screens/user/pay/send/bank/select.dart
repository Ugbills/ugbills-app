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

                          searchedList = bank!.banks!
                              .where((element) => element.name!
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
                        child: bank!.banks!.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.account_balance,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'No banks available',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: bank.banks!
                                    .where((element) => element.name!
                                        .toLowerCase()
                                        .contains(_searchedWord.toLowerCase()))
                                    .length,
                                itemBuilder: (context, index) {
                                  final filteredBanks = bank.banks!
                                      .where((element) => element.name!
                                          .toLowerCase()
                                          .contains(
                                              _searchedWord.toLowerCase()))
                                      .toList();

                                  if (filteredBanks.isEmpty) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(32.0),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.search_off,
                                              size: 48,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(height: 16),
                                            Text(
                                              'No banks found',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                                  final bankItem = filteredBanks[index];

                                  return InkWell(
                                    onTap: () {
                                      ref
                                          .read(
                                              widget.bankNameProvider.notifier)
                                          .state = bankItem.name!;
                                      ref
                                          .read(
                                              widget.bankCodeProvider.notifier)
                                          .state = bankItem.code!;
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? ZealPalette.lighterBlack
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Icon(
                                              Icons.account_balance,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              bankItem.name!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                        ],
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
