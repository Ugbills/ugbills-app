import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/svg.dart';

class ZeelTextField extends StatelessWidget {
  final String hint;
  final bool enabled;
  final bool copy;
  final TextEditingController? controller;
  const ZeelTextField({
    super.key,
    required this.hint,
    required this.enabled,
    this.controller,
    this.copy = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: controller!.text))
                  .then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("copied to clipboard")));
              });
            },
            child: TextField(
              controller: controller,
              enabled: enabled,
              decoration: InputDecoration(
                fillColor: enabled ? Colors.white : Colors.grey[250],
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
  final TextEditingController? controller;
  final void Function()? onTap;
  const ZeelSelectTextField(
      {super.key, required this.hint, this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          height: 70,
          child: TextField(
            controller: controller,
            enabled: false,
            decoration: InputDecoration(
              fillColor: Colors.white,
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
