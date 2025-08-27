import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeelpay/screens/user/trade/sell/confirm.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class SellCrypto extends StatefulWidget {
  final String cryptoCoin, network, currency;
  const SellCrypto(
      {super.key,
      required this.cryptoCoin,
      required this.currency,
      required this.network});

  @override
  State<SellCrypto> createState() => _SellCryptoState();
}

class _SellCryptoState extends State<SellCrypto> {
  final TextEditingController _amountController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Sell ${widget.cryptoCoin}',
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
                  const ZeelTextFieldTitle(text: "Amount to Sell"),
                  TextFormField(
                    enabled: true,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildShortcutButton("20"),
                      _buildShortcutButton("50"),
                      _buildShortcutButton("100"),
                      _buildShortcutButton("500"),
                    ],
                  ),
                  // const SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     const Text("You get: "),
                  //     Text(
                  //       _formattedPriceInNaira,
                  //       style: const TextStyle(fontWeight: FontWeight.w700),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            ZeelButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConfirmSellDetails(
                        currency: widget.currency,
                        coin: widget.cryptoCoin,
                        title: widget.cryptoCoin,
                        amount: double.parse(_amountInDollar),
                        network: widget.network,
                      ),
                    ));
              },
              text: "Sell",
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
