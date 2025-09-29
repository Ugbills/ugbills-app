import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/themes/palette.dart';

class ZeelActionButton extends StatelessWidget {
  final String text;
  final String icon;
  final Color color;
  final Function()? onTap;
  const ZeelActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShadImage.square(
                  icon,
                  color: isDark
                      ? ZealPalette.primaryBlue
                      : ZealPalette.primaryBlue,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              color: isDark ? Colors.grey.shade300 : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
