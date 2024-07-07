import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/svg.dart';

class ZeelTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leadingImage;
  final String? route;
  const ZeelTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leadingImage,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.withOpacity(0.05),
      shadowColor: Colors.transparent,
      child: ListTile(
        title: Text(title, style: ShadTheme.of(context).textTheme.h4),
        subtitle: Text(subtitle,
            overflow: TextOverflow.clip,
            style: ShadTheme.of(context).textTheme.muted),
        leading: Container(
          padding: const EdgeInsets.all(10),
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              color: Color(0xffE9E6EB), shape: BoxShape.circle),
          child: ShadImage.square(
            leadingImage,
            size: 30,
            fit: BoxFit.contain,
          ),
        ),
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShadImage.square(
              ZeelSvg.forwardArrow,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
