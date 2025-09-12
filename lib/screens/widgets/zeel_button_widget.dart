import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/themes/palette.dart';

class ZeelButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final bool? isLoading;

  const ZeelButton({
    super.key,
    this.onPressed,
    this.text = "Log in",
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = ShadTheme.of(context).brightness == Brightness.dark;
    return SizedBox(
        width: double.infinity,
        height: 57.0,
        child: FilledButton(
            style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                backgroundColor: const Color(0xff1C41AB)),
            onPressed: isLoading! ? () {} : onPressed,
            child: isLoading!
                ? Center(
                    child: CircularProgressIndicator(
                    color: isDark
                        ? ShadTheme.of(context).colorScheme.primary
                        : Colors.white,
                  ))
                : Text(
                    text!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.white),
                  )));
  }
}

class ZeelAltButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;

  const ZeelAltButton({
    super.key,
    this.onPressed,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = ShadTheme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: double.infinity,
      height: 57.0,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(
            width: 1.0,
            color: isDark ? ZealPalette.lightBlue : const Color(0xff1C41AB),
          ),
          backgroundColor: ShadTheme.of(context).colorScheme.background,
        ),
        onPressed: onPressed,
        child: Text(
          text!,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : const Color(0xff1C41AB),
              fontSize: 16),
        ),
      ),
    );
  }
}

class ZeelBackButton extends StatelessWidget {
  final Color? color;
  const ZeelBackButton({
    super.key,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = ShadTheme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: const Border.fromBorderSide(BorderSide(color: Colors.grey)),
        ),
        // height: 48,
        // width: 48,
        child: Icon(
          Icons.arrow_back_ios,
          color: isDark ? Colors.grey : Colors.black,
        ),
      ),
    );
  }
}
