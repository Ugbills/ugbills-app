import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          ZeelTitleText(text: "We are here to help"),
        ],
      ),
    );
  }
}
