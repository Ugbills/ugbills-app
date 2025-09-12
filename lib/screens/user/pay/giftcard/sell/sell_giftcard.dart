import 'package:flutter/material.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/screens/user/pay/giftcard/sell/giftcard_details.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class SellGiftcard extends StatefulWidget {
  const SellGiftcard({super.key});

  @override
  SellGiftcardState createState() => SellGiftcardState();
}

class SellGiftcardState extends State<SellGiftcard> {
  final List<Map<String, String>> allItems = [
    {'image': ZeelPng.netflix, 'name': 'Netflix'},
    {'image': ZeelPng.amazongiftcard, 'name': 'Amazon'},
    {'image': ZeelPng.itunes, 'name': 'iTunes'},
    {'image': ZeelPng.bestbuy, 'name': 'Best Buy'},
    {'image': ZeelPng.walmart, 'name': 'Walmart'},
    {'image': ZeelPng.xbox, 'name': 'Xbox'},
    {'image': ZeelPng.netflix, 'name': 'Netflix'},
    {'image': ZeelPng.amazongiftcard, 'name': 'Amazon'},
    {'image': ZeelPng.itunes, 'name': 'iTunes'},
    {'image': ZeelPng.bestbuy, 'name': 'Best Buy'},
    {'image': ZeelPng.walmart, 'name': 'Walmart'},
    {'image': ZeelPng.xbox, 'name': 'Xbox'},
  ];

  List<Map<String, String>> displayedItems = [];
  int itemsToShow = 6;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedItems = allItems.take(itemsToShow).toList();
  }

  void loadMoreItems() {
    setState(() {
      itemsToShow += 6;
      displayedItems = allItems.take(itemsToShow).toList();
    });
  }

  void filterItems(String query) {
    setState(() {
      displayedItems = allItems
          .where((item) =>
              item['name']!.toLowerCase().contains(query.toLowerCase()))
          .take(itemsToShow)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        title: const Text(
          'Sell Gift Card',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          TextField(
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
          const SizedBox(height: 24),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: displayedItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SellGiftcardDetails(
                          title: displayedItems[index]['name']!,
                        ),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? ZealPalette.lighterBlack : Colors.white,
                    borderRadius: BorderRadius.circular(16),
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
                          child: Image.asset(
                            displayedItems[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ZeelTextFieldTitle(
                            text: displayedItems[index]['name']!),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: loadMoreItems,
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.transparent,
              side: const BorderSide(color: ZealPalette.primaryBlue),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            child: const Text(
              'Show More',
              style: TextStyle(color: ZealPalette.primaryBlue),
            ),
          ),
        ],
      ),
    );
  }
}
