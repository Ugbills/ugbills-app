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
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: controller!.text)).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("copied to clipboard")));
        });
      },
      child: SizedBox(
          height: 70,
          child: TextField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
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
              ),
            ),
          )),
    );
  }
}
