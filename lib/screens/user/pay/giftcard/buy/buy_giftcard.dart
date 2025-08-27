import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/providers/gift_card_provider.dart';
import 'package:zeelpay/screens/user/pay/giftcard/buy/giftcard_details.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class BuyGiftcard extends ConsumerStatefulWidget {
  const BuyGiftcard({super.key});

  @override
  BuyGiftcardState createState() => BuyGiftcardState();
}

class BuyGiftcardState extends ConsumerState<BuyGiftcard> {
  int itemsToShow = 100;
  int page = 1;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void loadMoreItems() {
    setState(() {
      page += 1;
    });
  }

  void filterItems(String query) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var country = ref.watch(selectedCountryProvider);
    var countryCode = ref.watch(selectedCountryCodeProvider);
    var giftCardsList = ref.watch(giftCardsProvider(
        countryCode: countryCode, limit: itemsToShow, page: page));
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: const Text(
          'Buy Gift Card',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextFormField(
                controller: searchController,
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
                  hintText: "Search for a brand or store",
                  suffixIcon: const Icon(Icons.search),
                ),
                onChanged: filterItems,
              ),
              const SizedBox(height: 10),
              ZeelSelectTextField(
                hint: country.isEmpty ? "Select Country" : country,
                onTap: () {
                  Navigator.push(
                      context, _createRoute(const GiftCountryWidget()));
                },
              ),
              const SizedBox(height: 24),
              giftCardsList.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Column(
                    children: [
                      Text(error.toString()),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(stackTrace.toString()),
                    ],
                  ),
                ),
                data: (cards) => GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: cards["data"]["content"].length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Go.to(BuyGiftcardDetails(
                          country: country,
                          senderFee: cards["data"]["content"][index]
                              ["senderFee"],
                          redeemInfo: cards["data"]["content"][index]
                              ["redeemInstruction"]["verbose"],
                          fixedRecipientDenominations: cards["data"]["content"]
                              [index]["fixedRecipientDenominations"],
                          title: cards["data"]["content"][index]["productName"],
                          fixedPrice: cards["data"]["content"][index]
                                      ["denominationType"]
                                  .toString()
                                  .toLowerCase() ==
                              "fixed",
                          iconUrl: cards["data"]["content"][index]["logoUrls"]
                              [0],
                          unitPrice: cards["data"]["content"][index]
                              ["unitPrice"],
                          countryCode: cards["data"]["content"][index]
                              ["country"]["isoName"],
                          productId: cards["data"]["content"][index]
                                  ["productId"]
                              .toString(),
                          brandId: cards["data"]["content"][index]["brand"]
                                  ["brandId"]
                              .toString(),
                          productName: cards["data"]["content"][index]
                              ["productName"],
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color:
                              isDark ? ZealPalette.lighterBlack : Colors.white,
                          border: Border.all(color: ZealPalette.darkerGrey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.network(
                                  cards["data"]["content"][index]["logoUrls"]
                                      [0],
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Flexible(
                                  child: ZeelTextFieldTitle(
                                      text: cards["data"]["content"][index]
                                          ["productName"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: loadMoreItems,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: ZealPalette.primaryPurple),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Show More',
                  style: TextStyle(color: ZealPalette.primaryPurple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final selectedCountryProvider = StateProvider.autoDispose<String>((ref) {
  return "Nigeria";
});

final selectedCountryCodeProvider = StateProvider.autoDispose<String>((ref) {
  return "NG";
});

class GiftCountryWidget extends ConsumerWidget {
  const GiftCountryWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var country = ref.watch(giftCardCountriesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 24),
        child: country.when(
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            data: (countries) => ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: countries!.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SizedBox(
                      width: 30,
                      height: 30,
                      child: ShadImage(
                        countries.data![index].flagUrl!,
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      ref.read(selectedCountryProvider.notifier).state =
                          countries.data![index].name!;
                      ref.read(selectedCountryCodeProvider.notifier).state =
                          countries.data![index].isoName!;

                      Go.back();
                    },
                    title: Text(countries.data![index].name!.toUpperCase()),
                    trailing: Text(
                      countries.data![index].isoName!.toUpperCase(),
                      overflow: TextOverflow.clip,
                    ),
                  );
                })),
      ),
    );
  }
}

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
