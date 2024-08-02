import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';

class SendByUsername extends StatelessWidget {
  const SendByUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          ZeelTextFieldTitle(text: "Username"),
          ZeelTextField(hint: "@", enabled: true),
        ],
      ),
    );
  }
}

// Widget 