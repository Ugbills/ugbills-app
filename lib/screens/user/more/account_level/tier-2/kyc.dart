import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/more/account_level/congrats.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class KYCVerification extends StatefulWidget {
  const KYCVerification({super.key});

  @override
  State<KYCVerification> createState() => _KYCVerificationState();
}

class _KYCVerificationState extends State<KYCVerification> {
  DateTime? _selectedDate;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const ZeelTitleText(text: "KYC Verification"),
                    const Text(
                        "Please fill in the correct information below. KYC is an important step to help reduce fraud."),
                    const SizedBox(height: 24),
                    const ZeelTextFieldTitle(text: "Date of Birth"),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _showDatePicker,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ZealPalette.darkerGrey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate != null
                                  ? "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}"
                                  : "Select Date of Birth",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const ZeelTextFieldTitle(text: "BVN"),
                    const ZeelTextField(
                        hint: "Enter 11 digit BVN Number", enabled: true),
                  ],
                ),
              ),
              ZeelButton(
                text: "Submit",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Congrats()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
