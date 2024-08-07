import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeelpay/screens/user/pay/giftcard/confirm_giftcard_details.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class SellGiftcardDetails extends StatefulWidget {
  final String title;
  const SellGiftcardDetails({super.key, this.title = 'Netflix'});

  @override
  State<SellGiftcardDetails> createState() => _SellGiftcardDetailsState();
}

class _SellGiftcardDetailsState extends State<SellGiftcardDetails> {
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

  String? selectedCountry;
  final List<String> items = [
    'Canada',
    'USA',
    'Australia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        title: Text(
          'Sell ${widget.title}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const ZeelTextFieldTitle(text: "Country"),
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
              value: selectedCountry,
              underline: Container(color: Colors.transparent),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCountry = newValue;
                });
              },
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildShortcutButton("5"),
              _buildShortcutButton("10"),
              _buildShortcutButton("15"),
              _buildShortcutButton("50"),
              _buildShortcutButton("100"),
            ],
          ),
          const SizedBox(height: 16),
          const ZeelTextFieldTitle(text: "Amount to buy"),
          const SizedBox(height: 12),
          TextFormField(
            enabled: true,
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
          const ZeelTextFieldTitle(
              text:
                  "Upload a clear image of the gift card and it’s receipt below"),
          const Text(
            "File max is not exceed 5MB",
            style: TextStyle(
              color: ZealPalette.rustColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _uploadImage(context),
          const SizedBox(height: 12),
          const ZeelTextFieldTitle(text: "Extra Comment (Optional)"),
          const ZeelTextField(
            enabled: true,
            hint: "Additional info",
          ),
          const SizedBox(height: 45),
          ZeelButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConfirmGiftcardDetails(
                      title: widget.title,
                      transactionID: '32324defkfdc',
                      usdAmount: '\$50',
                      nairaAmount: '₦55,000',
                      dateAndTime: 'Mar 09 2024, 5:04PM',
                      fee: '₦150',
                    ),
                  ));
            },
            text: "Sell",
          ),
        ],
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
                ? ZealPalette.primaryPurple
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

Widget _uploadImage(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 50),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: isDark ? ZealPalette.lighterBlack : Colors.white,
      border: Border.all(
        color: ZealPalette.darkerGrey,
      ),
    ),
    child: const Column(
      children: [
        Icon(Icons.camera_alt_outlined, size: 45),
        Text(
          "Tap to Upload Image here",
          style: TextStyle(color: Colors.grey),
        )
      ],
    ),
  );
}
