import 'package:flutter/material.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        title: const Text(
          "Coming Soon",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const ZeelBackButton(
          color: Colors.white,
        ),
      ),
      body: const Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
