import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/themes/palette.dart';

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
      child: Container(
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width / 3.7,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor:
                  isDark ? ZealPalette.lighterPurple : Colors.grey[200],
              child: ShadImage.square(
                icon,
                color: isDark ? ZealPalette.primaryPurple : Colors.black,
                size: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: isDark ? Colors.grey.shade300 : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
