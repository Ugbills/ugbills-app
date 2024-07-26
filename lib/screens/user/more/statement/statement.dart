import 'package:flutter/material.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class AccountStatement extends StatefulWidget {
  const AccountStatement({super.key});

  @override
  State<AccountStatement> createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {
  DateTime? _endDate;
  DateTime? _startDate;
  final String _selectedFormat = "PDF";

  void _showStartDate() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    ).then((startDateValue) {
      if (startDateValue != null) {
        setState(() {
          _startDate = startDateValue;
        });
      }
    });
  }

  void _showEndDate() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    ).then((endDateValue) {
      if (endDateValue != null) {
        setState(() {
          _endDate = endDateValue;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const ZeelTextFieldTitle(text: "Select Currency"),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ZealPalette.darkerGrey),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("NGN"),
                          Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const ZeelTextFieldTitle(text: "Start Date"),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _showStartDate,
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
                              _startDate != null
                                  ? "${_startDate!.day}-${_startDate!.month}-${_startDate!.year}"
                                  : "Select start date",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const ZeelTextFieldTitle(text: "End Date"),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _showEndDate,
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
                              _endDate != null
                                  ? "${_endDate!.day}-${_endDate!.month}-${_endDate!.year}"
                                  : "Select end date",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    // DropdownButton(
                    //     items: [],
                    //     onChanged: ((newValue) {
                    //       setState(() {
                    //         _selectedFormat = newValue;
                    //       });
                    //     }))
                  ],
                ),
              ),
              ZeelButton(
                text: "Generate Statement",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
