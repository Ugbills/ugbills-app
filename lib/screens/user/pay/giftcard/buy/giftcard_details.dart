import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ugbills/helpers/common/data_formatter.dart';
import 'package:ugbills/screens/user/pay/giftcard/confirm_giftcard_details.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';
import 'package:ugbills/themes/palette.dart';

class BuyGiftcardDetails extends StatefulWidget {
  final String title;
  final String iconUrl;
  final String countryCode;
  final String productName;
  final dynamic unitPrice;
  final String productId;
  final String brandId;
  final String country;
  final String redeemInfo;
  final bool fixedPrice;
  final dynamic senderFee;
  final List<dynamic>? fixedRecipientDenominations;
  final Map<String, dynamic>? fixedRecipientToSenderDenominationsMap;
  final dynamic minSenderDenomination;
  final dynamic maxSenderDenomination;
  const BuyGiftcardDetails(
      {super.key,
      required this.title,
      required this.iconUrl,
      required this.productName,
      required this.unitPrice,
      required this.countryCode,
      required this.productId,
      required this.brandId,
      required this.country,
      required this.fixedPrice,
      this.fixedRecipientDenominations,
      this.fixedRecipientToSenderDenominationsMap,
      this.minSenderDenomination,
      this.maxSenderDenomination,
      required this.redeemInfo,
      this.senderFee});

  @override
  State<BuyGiftcardDetails> createState() => _BuyGiftcardDetailsState();
}

class _BuyGiftcardDetailsState extends State<BuyGiftcardDetails> {
  final TextEditingController _amountController = TextEditingController();
  String _amountInDollar = "";
  String? _selectedAmount; // To store the selected shortcut amount

  @override
  void initState() {
    super.initState();
    _amountController.text = _amountInDollar;
    _amountController.addListener(_updateAmountFromTextField);
  }

  @override
  void dispose() {
    _amountController.removeListener(_updateAmountFromTextField);
    _amountController.dispose();
    super.dispose();
  }

  void _updateAmount(String tappedAmount) {
    setState(() {
      _amountInDollar = tappedAmount;
      _amountController.text = _amountInDollar;
      _selectedAmount = tappedAmount; // Update the selected amount
    });
  }

  void _updateAmountFromTextField() {
    final input = _amountController.text.replaceAll(RegExp(r'[^0-9.]'), '');
    setState(() {
      _amountInDollar = input.isNotEmpty ? input : "0.00";
      _selectedAmount =
          null; // Reset the selected amount when manually entering
    });
  }

  String get _formattedPriceInNaira {
    final amount = double.tryParse(_amountInDollar) ?? 0.00;
    final priceInNaira = amount * 1800;
    final format =
        NumberFormat.currency(symbol: "₦", decimalDigits: 2, locale: "en_NG");
    return format.format(priceInNaira);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        forceMaterialTransparency: true,
        title: Text(
          widget.title,
        ),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ZeelScrollable(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ZeelTextFieldTitle(text: "Country"),
                ZeelTextField(enabled: false, hint: widget.country),
                widget.fixedRecipientDenominations!.isNotEmpty
                    ? SizedBox(
                        height: 40,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemCount: widget.fixedRecipientDenominations!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return _buildShortcutButton(
                              widget.fixedRecipientDenominations![index]
                                  .toString(),
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                widget.fixedRecipientDenominations!.isNotEmpty
                    ? const SizedBox(height: 16)
                    : const SizedBox.shrink(),
                const ZeelTextFieldTitle(text: "Amount to buy"),
                const SizedBox(height: 12),
                TextFormField(
                  enabled: widget.fixedPrice ? false : true,
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    prefixText: '\$',
                    hintText: "0.00",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Price in Naira: "),
                    Text(
                      _formattedPriceInNaira,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isDark
                        ? ZealPalette.orange
                        : ZealPalette.rustColor.withAlpha(20),
                    border: Border.all(color: ZealPalette.rustColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Note",
                        style: TextStyle(
                          color: ZealPalette.rustColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "The gift card will be delivered instantly via email.",
                        style: TextStyle(
                          color: isDark ? ZealPalette.rustColor : Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Redeem instruction",
                        style: TextStyle(
                          color: ZealPalette.rustColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.redeemInfo,
                        style: TextStyle(
                          color: isDark ? ZealPalette.rustColor : Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ZeelButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ConfirmGiftcardDetails(
                                  iconUrl: widget.iconUrl,
                                  productName: widget.productName,
                                  unitPrice: widget.fixedPrice
                                      ? _amountController.text
                                      : widget.unitPrice,
                                  countryCode: widget.countryCode,
                                  productId: widget.productId,
                                  brandId: widget.brandId,
                                  usdAmount: _amountController.text,
                                  nairaAmount: _formattedPriceInNaira,
                                  dateAndTime: formartDateTime(
                                      DateTime.now().toString()),
                                  fee: '₦${widget.senderFee}',
                                  title: widget.title,
                                ),
                              ));
                        },
                        text: "Buy",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShortcutButton(String amount) {
    return GestureDetector(
      onTap: () => _updateAmount(amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedAmount == amount
                ? ZealPalette.primaryBlue
                : ZealPalette.darkerGrey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "\$$amount",
          style: TextStyle(color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
