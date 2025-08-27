import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ZeelNetwork extends StatelessWidget {
  final String icon;
  final bool? selected;
  final void Function()? onTap;
  const ZeelNetwork({
    super.key,
    required this.icon,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: ShadImage("https://devapi.zeelpay.app$icon"),
            ),
          ),
          selected!
              ? Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        weight: 10,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class ZeelQuickAmount extends StatelessWidget {
  final ShadThemeData theme;
  final void Function()? onTap;

  final String text;
  const ZeelQuickAmount({
    super.key,
    required this.theme,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(text, style: theme.textTheme.small),
        ),
      ),
    );
  }
}
