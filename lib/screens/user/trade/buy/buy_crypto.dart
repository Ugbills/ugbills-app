import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/screens/user/trade/buy/confirm.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class BuyCrypto extends StatefulWidget {
  final String cryptoCoin, network, currency;
  const BuyCrypto(
      {super.key,
      required this.network,
      required this.cryptoCoin,
      required this.currency});

  @override
  State<BuyCrypto> createState() => _BuyCryptoState();
}

class _BuyCryptoState extends State<BuyCrypto> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _amountInDollar = "";

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
    });
  }

  void _updateAmountFromTextField() {
    final input = _amountController.text.replaceAll(RegExp(r'[^0-9.]'), '');
    setState(() {
      _amountInDollar = input.isNotEmpty ? input : "0.00";
    });
  }

  String get _formattedPriceInNaira {
    final amount = double.tryParse(_amountInDollar) ?? 0.00;
    final priceInNaira = amount * 1800;
    final format =
        NumberFormat.currency(symbol: "₦", decimalDigits: 2, locale: "en_NG");
    return format.format(priceInNaira);
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leadingWidth: 100,
        title: Text(
          'Buy ${widget.cryptoCoin}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: ZeelBackButton(
          color: isDark ? ZealPalette.lighterBlack : Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const ZeelTextFieldTitle(text: "Amount to buy"),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: amountValidator,
                          enabled: true,
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildShortcutButton("20"),
                            _buildShortcutButton("50"),
                            _buildShortcutButton("100"),
                            _buildShortcutButton("500"),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Price in Naira: "),
                            Text(
                              _formattedPriceInNaira,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ZeelTextFieldTitle(
                            text: "${widget.network.toUpperCase()} Address"),
                        ZeelTextField(
                            validator: addressValidator,
                            enabled: true,
                            controller: _addressController,
                            hint: "Paste wallet address"),
                      ],
                    ),
                  ),
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
                          "Please paste only ${widget.cryptoCoin.toUpperCase()} (${widget.network.toUpperCase()}) Wallet address, putting a different wallet address might lead to crypto loss.",
                          style: TextStyle(
                              color:
                                  isDark ? ZealPalette.rustColor : Colors.black,
                              fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ZeelButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConfirmBuyDetails(
                          network: widget.network,
                          address: _addressController.text,
                          currency: widget.currency,
                          title: widget.cryptoCoin,
                          amount: double.parse(_amountInDollar),
                        ),
                      ));
                }
              },
              text: "Buy",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutButton(String amount) {
    return FilledButton(
      onPressed: () => _updateAmount(amount),
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: const BorderSide(
          color: ZealPalette.darkerGrey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        "\$$amount",
        style: TextStyle(color: Colors.grey.shade700),
      ),
    );
  }
}
