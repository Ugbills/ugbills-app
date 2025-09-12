import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/providers/crypto_provider.dart';
import 'package:ugbills/screens/user/trade/buy/buy_crypto.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class BuyCryptoOptions extends ConsumerWidget {
  const BuyCryptoOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    var supported = ref.watch(fetchCoinListProvider);

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 100,
        centerTitle: true,
        title: const Text('Buy Crypto',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: ZeelBackButton(
          color: isDark ? ZealPalette.lighterBlack : Colors.white,
        ),
      ),
      body: supported.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'An error occurred',
                      style: TextStyle(
                        color: isDark ? ZealPalette.lighterBlack : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ZeelButton(
                      onPressed: () {
                        ref.refresh(fetchCoinListProvider);
                      },
                      text: 'Retry',
                    ),
                  ],
                ),
              ),
          data: (crypto) => ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: crypto!.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isDark ? ZealPalette.lighterBlack : Colors.white,
                  ),
                  child: ListTile(
                    onTap: () {
                      //bottom sheet for user to select network
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: isDark
                                  ? ZealPalette.lighterBlack
                                  : Colors.white,
                              child: Wrap(
                                children: [
                                  ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const Divider(),
                                      shrinkWrap: true,
                                      itemCount:
                                          crypto.data![index].networks!.length,
                                      itemBuilder: (context, dex) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: isDark
                                                ? ZealPalette.lighterBlack
                                                : Colors.white,
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => BuyCrypto(
                                                      network: crypto
                                                          .data![index]
                                                          .networks![dex],
                                                      currency: crypto
                                                          .data![index]
                                                          .currency!,
                                                      cryptoCoin: crypto
                                                          .data![index].name!,
                                                    ),
                                                  ));
                                            },
                                            title: Text(crypto
                                                .data![index].networks![dex]
                                                .toUpperCase()),
                                            trailing: const Icon(Icons
                                                .arrow_forward_ios_rounded),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            );
                          });
                    },
                    leading: ShadImage(
                        "https://devapi.UgBills.app${crypto.data![index].icon!}"),
                    title: Text(crypto.data![index].name!),
                    subtitle: Text(crypto.data![index].currency!.toUpperCase()),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                );
              })),
    );
  }
}
