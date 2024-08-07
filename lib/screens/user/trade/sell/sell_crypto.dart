import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeelpay/screens/user/trade/sell/confirm.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class SellCrypto extends StatefulWidget {
  final String cryptoCoin, network;
  const SellCrypto(
      {super.key, required this.cryptoCoin, required this.network});

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sell ${widget.cryptoCoin}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const ZeelBackButton(
          color: Colors.white,
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("You get: "),
                      Text(
                        _formattedPriceInNaira,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ZeelTextFieldTitle(text: "${widget.network} Address"),
                  ZeelTextField(
                    enabled: false,
                    copy: true,
                    controller: TextEditingController(
                      text: "0x000000000000000000000000000000000000dEaD",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ZealPalette.rustColor.withAlpha(20),
                      border: Border.all(color: ZealPalette.rustColor),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note",
                          style: TextStyle(
                            color: ZealPalette.rustColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Please send only USDT (TRC-20) to the above generated Wallet address.",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ZeelButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConfirmSellDetails(
                        title: widget.cryptoCoin,
                        network: widget.network,
                      ),
                    ));
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
