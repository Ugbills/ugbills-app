import 'package:flutter/material.dart';
import 'package:zeelpay/themes/palette.dart';

class BeneficiaryTile extends StatelessWidget {
  final String name;
  final String bank;
  final String accountNumber;
  final String sessionId;
  const BeneficiaryTile({
    super.key,
    required this.name,
    required this.bank,
    required this.accountNumber,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? ZealPalette.lighterBlack
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset("assets/images/access-bank.png"),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    bank,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    accountNumber,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
