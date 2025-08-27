import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-3/kyc_model.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-3/quality.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class TakeASelfie extends ConsumerWidget {
  final AddressData addressData;
  const TakeASelfie({super.key, required this.addressData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Image.asset("assets/images/selfie.png"),
            const SizedBox(height: 10),
            const ZeelTitleText(text: "Take a Selfie"),
            const SizedBox(height: 10),
            const Text(
              "This will help us identify who owns this account.",
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(flex: 2),
            ZeelButton(
              text: "Take a Selfie",
              onPressed: () => getImage(addressData),
            )
          ],
        ),
      ),
    );
  }
}

Future getImage(AddressData data) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  Go.to(CheckQuality(
    image: File(pickedImage!.path),
    addressData: data,
  ));
}
