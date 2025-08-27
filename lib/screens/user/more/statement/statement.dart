import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/controllers/user/user_controller.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

// import '../../../widgets/zeel_button_widget.dart';

class AccountStatement extends StatefulWidget {
  const AccountStatement({super.key});

  @override
  State<AccountStatement> createState() => _AccountStatementState();
}

class _AccountStatementState extends State<AccountStatement> {
  DateTime? _endDate;
  DateTime? _startDate;
  String _selectedFormat = "pdf";
  // final String _selectedFormat = "PDF";

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

  final fileFormat = {
    'pdf': 'PDF',
    'xlsx': 'XLSX',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Account Statement'),
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
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
                    const SizedBox(height: 12),
                    const ZeelTextFieldTitle(text: "File Format"),
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ShadSelect<String>(
                        onChanged: (value) => setState(() {
                          _selectedFormat = value;
                        }),
                        placeholder: const Text(
                          'PDF',
                          style: TextStyle(color: Colors.grey),
                        ),
                        decoration: ShadDecoration(
                            merge: false,
                            border: ShadBorder(
                                radius: BorderRadius.circular(15),
                                width: 0.5,
                                color: ZealPalette.darkerGrey),
                            focusedBorder: ShadBorder(
                                radius: BorderRadius.circular(15),
                                color: ZealPalette.darkerGrey,
                                width: 0.5),
                            secondaryBorder: ShadBorder(
                                radius: BorderRadius.circular(15),
                                color: ZealPalette.darkerGrey,
                                width: 0.5)),
                        options: [
                          ...fileFormat.entries.map((e) =>
                              ShadOption(value: e.key, child: Text(e.value))),
                        ],
                        selectedOptionBuilder: (context, value) => Text(
                          fileFormat[value]!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, child) => ZeelButton(
                  text: "Generate Statement",
                  isLoading: ref.watch(isLoadingProvider),
                  onPressed: _startDate != null && _endDate != null
                      ? () async {
                          ref.read(isLoadingProvider.notifier).state = true;
                          UserController().generateStatement(
                              ref: ref,
                              startDate: _startDate.toString(),
                              endDate: _endDate.toString(),
                              format: _selectedFormat.toString(),
                              context: context);
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
