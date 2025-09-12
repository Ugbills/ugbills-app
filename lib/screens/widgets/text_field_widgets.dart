// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/helpers/forms/validators.dart';
import 'package:ugbills/helpers/snacks/snacks_helper.dart';
import 'package:ugbills/themes/palette.dart';

class ZeelTextField extends StatelessWidget {
  final String? hint;
  final bool enabled;
  final TextInputType? keyboardType;
  final int? maxLength;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool copy;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  const ZeelTextField({
    super.key,
    this.hint,
    this.keyboardType,
    required this.enabled,
    this.controller,
    this.maxLength,
    this.copy = false,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = ShadTheme.of(context).brightness == Brightness.dark;

    return SizedBox(
        height: 70,
        child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: controller!.text))
                  .then((_) {
                successSnack(
                  context,
                  "Copied to clipboard",
                );
              });
            },
            child: TextFormField(
              controller: controller,
              validator: validator,
              onChanged: onChanged,
              maxLength: maxLength,
              keyboardType: keyboardType,
              enabled: enabled,
              onEditingComplete: onEditingComplete,
              decoration: InputDecoration(
                counterText: "",
                fillColor: isDark && enabled
                    ? ZealPalette.lighterBlack
                    : isDark && !enabled
                        ? ZealPalette.lighterBlack
                        : enabled
                            ? Colors.white
                            : Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: ShadTheme.of(context).colorScheme.primary,
                      width: 0.5),
                ),
                hintText: hint,
                suffixIcon: copy
                    ? const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ShadImage.square(
                          ZeelSvg.copy,
                          size: 20.0,
                          fit: BoxFit.contain,
                        ),
                      )
                    : null,
                hintStyle: ShadTheme.of(context).textTheme.muted,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            )));
  }
}

class ZeelSelectTextField extends StatelessWidget {
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function()? onTap;
  const ZeelSelectTextField(
      {super.key,
      required this.hint,
      this.controller,
      this.validator,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          height: 70,
          child: TextFormField(
            validator: validator,
            controller: controller,
            enabled: false,
            decoration: InputDecoration(
              fillColor: isDark ? ZealPalette.lighterBlack : Colors.white,
              filled: true,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
              ),
              hintText: hint,
              suffixIcon: const Padding(
                padding: EdgeInsets.all(10.0),
                child: ShadImage.square(
                  ZeelSvg.downArrow,
                  size: 20.0,
                  fit: BoxFit.contain,
                  color: Colors.grey,
                ),
              ),
              hintStyle: ShadTheme.of(context).textTheme.muted,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )),
    );
  }
}

class PassWordFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final void Function(String)? onChanged;
  final String? hint;
  final String? Function(String?)? validator;
  const PassWordFormField(
      {super.key,
      required this.controller,
      this.keyboardType = TextInputType.visiblePassword,
      this.validator = passwordValidator,
      this.hint = "Enter your password",
      this.onChanged,
      this.maxLength});

  @override
  State<PassWordFormField> createState() => _PassWordFormFieldState();
}

var show = true;

class _PassWordFormFieldState extends State<PassWordFormField> {
  @override
  Widget build(BuildContext context) {
    bool isDark = ShadTheme.of(context).brightness == Brightness.dark;
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      obscureText: show,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
          counterText: "",
          hintText: widget.hint,
          fillColor: isDark ? ZealPalette.lighterBlack : Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
                color: ShadTheme.of(context).colorScheme.primary, width: 0.5),
          ),
          suffixIcon: IconButton(
            icon: ShadImage(show ? ZeelSvg.eye : ZeelSvg.eyeSlash),
            onPressed: () {
              setState(() {
                show = !show;
              });
            },
          ),
          hintStyle: ShadTheme.of(context).textTheme.muted,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          )),
    );
  }
}

class ZeelPassWordTextFieled extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const ZeelPassWordTextFieled(
      {super.key, required this.controller, this.validator});

  @override
  State<ZeelPassWordTextFieled> createState() => _ZeelPassWordTextFieledState();
}

class _ZeelPassWordTextFieledState extends State<ZeelPassWordTextFieled> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: obscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: isDark ? ZealPalette.lighterBlack : Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? Colors.grey : ZealPalette.darkerGrey,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              obscure = !obscure;
            });
          },
        ),
      ),
    );
  }
}
