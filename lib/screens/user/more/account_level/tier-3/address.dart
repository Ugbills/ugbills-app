import 'package:flutter/material.dart';
import 'package:ugbills/screens/user/more/account_level/tier-3/kyc_model.dart';
import 'package:ugbills/screens/user/more/account_level/tier-3/selfie.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/screens/widgets/zeel_scrollable_widget.dart';

class EnterAddress extends StatelessWidget {
  EnterAddress({super.key});

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ZeelBackButton(),
        leadingWidth: 100,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: ZeelScrollable(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ZeelTextFieldTitle(text: "House Address"),
                const SizedBox(height: 6),
                ZeelTextField(
                    hint: "Enter your address",
                    enabled: true,
                    controller: addressController),
                const ZeelTextFieldTitle(text: "City"),
                const SizedBox(height: 6),
                ZeelTextField(
                    hint: "Enter your city",
                    enabled: true,
                    controller: cityController),
                const ZeelTextFieldTitle(text: "State"),
                const SizedBox(height: 6),
                ZeelTextField(
                    hint: "Enter your state",
                    enabled: true,
                    controller: stateController),
                const ZeelTextFieldTitle(text: "Postal Code"),
                const SizedBox(height: 6),
                ZeelTextField(
                    hint: "Enter postal code",
                    enabled: true,
                    controller: postalCodeController),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ZeelButton(
                      text: "Continue",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TakeASelfie(
                                      addressData: AddressData(
                                          houseAddress: addressController.text,
                                          city: cityController.text,
                                          state: stateController.text,
                                          postalCode:
                                              postalCodeController.text),
                                    )));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
