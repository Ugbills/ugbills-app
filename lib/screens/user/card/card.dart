import 'package:flutter/material.dart';
import 'package:zeelpay/screens/user/card/create/create.dart';
import 'package:zeelpay/screens/user/card/available.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int mySwitch = 1;
    return mySwitch == 0 ? const CreateCardScreen() : const AvailableCards();
  }
}
