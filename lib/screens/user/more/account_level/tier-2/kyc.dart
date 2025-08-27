import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeelpay/controllers/user/user_controller.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class KYCVerification extends ConsumerStatefulWidget {
  const KYCVerification({super.key});

  @override
  ConsumerState<KYCVerification> createState() => _KYCVerificationState();
}

class _KYCVerificationState extends ConsumerState<KYCVerification> {
  DateTime? _selectedDate;

  final TextEditingController bvnController = TextEditingController();
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var isloading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const ZeelBackButton(),
        leadingWidth: 100,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const ZeelTitleText(text: "KYC Verification"),
                    Text(
                      "Please fill in the correct information below. KYC is an important step to help reduce fraud.",
                      style: TextStyle(
                        color: isDark ? Colors.grey : Colors.black,
                      ),
                    ),
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
                                  ? "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}"
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
                    ZeelTextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        controller: bvnController,
                        hint: "Enter 11 digit BVN Number",
                        enabled: true),
                  ],
                ),
              ),
              ZeelButton(
                text: "Submit",
                isLoading: isloading,
                onPressed:
                    bvnController.text.length < 11 || _selectedDate == null
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            ref.read(isLoadingProvider.notifier).state = true;
                            ref.read(userControllerProvider.notifier).submitBVN(
                                dob: _selectedDate!.month < 10
                                    ? "${_selectedDate!.year}-0${_selectedDate!.month}-${_selectedDate!.day}"
                                    : "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}",
                                bvn: bvnController.text,
                                context: context,
                                ref: ref);
                          },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
