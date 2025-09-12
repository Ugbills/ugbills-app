import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        forceMaterialTransparency: true,
        title: Text("About Us", style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          aboutTile(
            ZeelSvg.faq,
            "Frequently asked Questions",
            () {},
            context,
          ),
          aboutTile(
            ZeelSvg.terms,
            "Terms and Conditions",
            () {},
            context,
          ),
          aboutTile(
            ZeelSvg.policy,
            "Privacy Policy",
            () {},
            context,
          ),
        ],
      ),
    );
  }
}

Widget aboutTile(
    String imagePath, String title, Function()? onTap, BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: isDark ? ZealPalette.lighterBlack : Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ShadImage.square(imagePath, size: 42),
            const SizedBox(width: 12),
            ZeelTextFieldTitle(text: title),
          ],
        ),
        const Icon(Icons.arrow_forward_ios_rounded),
      ],
    ),
  );
}
