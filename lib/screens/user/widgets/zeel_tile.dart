import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/themes/palette.dart';

class ZeelTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String leadingImage;
  final String? route;
  final void Function()? onTap;
  const ZeelTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.leadingImage,
      this.route,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
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
      ),
    );
  }
}

class ZeelListTile extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final String? route;
  final void Function()? onTap;
  const ZeelListTile(
      {super.key,
      required this.title,
      required this.leadingIcon,
      this.route,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isDark ? ZealPalette.lighterBlack : Colors.white,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
        child: ListTile(
          title: Text(title,
              style: ShadTheme.of(context).textTheme.small.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: title.toString().toLowerCase() == "logout"
                      ? Colors.red
                      : null)),
          leading: Container(
            padding: const EdgeInsets.all(10),
            height: 40,
            width: 40,
            child: ShadImage.square(
              leadingIcon,
              size: 30,
              fit: BoxFit.contain,
            ),
          ),
          trailing: title.toString().toLowerCase() == "logout"
              ? const SizedBox.shrink()
              : const Column(
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
      ),
    );
  }
}
