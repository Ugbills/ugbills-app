import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/controllers/transfer/model.dart';
import 'package:zeelpay/controllers/transfer/transfer_controller.dart';
import 'package:zeelpay/screens/user/more/beneficiaries/beneficiaries.dart';
import 'package:zeelpay/screens/user/pay/send/bank/select.dart';
import 'package:zeelpay/screens/widgets/authenticate_transaction.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';

class BankTransfer extends HookConsumerWidget {
  BankTransfer({super.key});

  var sessionId = '';
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validatingName = useState<Future<AccountInfoModel?>?>(null);

    final isLoading = useFuture(validatingName.value).connectionState ==
        ConnectionState.waiting;

    var selectedBank = ref.watch(selectedBankProvider);
    var selectedBankCode = ref.watch(selectedBankCodeProvider);
    var saveBeneficiary = ref.watch(saveBeneficiaryProvider);
    var theme = ShadTheme.of(context);
    final amount = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        forceMaterialTransparency: true,
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ZeelScrollable(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ZeelTextFieldTitle(text: "Amount"),
                ZeelTextField(hint: "₦$amount", enabled: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShadButton.link(
                      text: Text(
                        "Choose Beneficiary",
                        style: theme.textTheme.small.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          _createRoute(
                            const SavedBeneficiaries(),
                          ),
                        );
                      },
                    )
                  ],
                ),
                const ZeelTextFieldTitle(text: "Select a Bank"),
                ZeelSelectTextField(
                  hint: selectedBank.isEmpty ? "Select a Bank" : selectedBank,
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        SelectBank(
                            selectedBankProvider, selectedBankCodeProvider),
                      ),
                    );
                  },
                ),
                selectedBank.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ZeelTextFieldTitle(text: "Account Number"),
                          ZeelTextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.length >= 10) {
                                //unfocus the textfield
                                FocusScope.of(context).unfocus();
                                var future = ref
                                    .read(transferControllerProvider.notifier)
                                    .validateAccount(
                                        accountNameController:
                                            _accountNameController,
                                        accountNumber:
                                            _accountNumberController.text,
                                        bankCode: selectedBankCode)
                                    .then((value) {
                                  if (value != null) {
                                    _accountNameController.text =
                                        value.accountName!;
                                    sessionId = value.nameEnquiryId!;
                                  }
                                });

                                validatingName.value = future;
                              }
                            },
                            hint: "Enter Account Number",
                            maxLength: 10,
                            controller: _accountNumberController,
                            enabled: true,
                            copy: false,
                          ),
                        ],
                      ),
                selectedBank.isEmpty
                    ? const SizedBox.shrink()
                    : isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : _accountNameController.text.isEmpty
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const ZeelTextFieldTitle(
                                      text: "Account Name"),
                                  ZeelTextField(
                                    hint: "",
                                    controller: _accountNameController,
                                    enabled: false,
                                  ),
                                ],
                              ),
                selectedBank.isEmpty | _accountNameController.text.isEmpty
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShadSwitch(
                            value: saveBeneficiary,
                            onChanged: (value) {
                              ref.read(saveBeneficiaryProvider.notifier).state =
                                  value;
                            },
                          ),
                          Text(
                            "Save Beneficiary",
                            style: theme.textTheme.small.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                const SizedBox(height: 20),
                selectedBank.isEmpty | _accountNameController.text.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ZeelTextFieldTitle(text: "Note (Optional)"),
                          ZeelTextField(
                            hint: "Add a note",
                            enabled: true,
                            controller: _noteController,
                          ),
                        ],
                      ),
                const Spacer(),
                ZeelButton(
                  text: "Send",
                  onPressed: _accountNameController.text.isEmpty ||
                          selectedBank.isEmpty ||
                          isLoading ||
                          amount.isEmpty ||
                          _accountNumberController.text.isEmpty
                      ? null
                      : () {
                          showModalBottomSheet(
                            scrollControlDisabledMaxHeightRatio:
                                double.maxFinite,
                            context: context,
                            builder: (_) => Container(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Confirm Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          icon: Image.asset(
                                              "assets/images/x.png")),
                                    ],
                                  ),
                                  showDetails("Amount", amount, context),
                                  showDetails(
                                      "Bank Name", selectedBank, context),
                                  showDetails("Account Name",
                                      _accountNameController.text, context),
                                  showDetails("Fee", "₦20.00", context),
                                  const SizedBox(height: 24),
                                  ZeelButton(
                                    text: "Confirm",
                                    onPressed: () {
                                      Go.to(ConfirmTransaction(
                                        onPinComplete: (pin) {
                                          ref
                                              .read(transferControllerProvider
                                                  .notifier)
                                              .transfer(
                                                  context: context,
                                                  sessionId: sessionId,
                                                  note: _noteController.text,
                                                  pin: pin!,
                                                  ref: ref,
                                                  amount: double.parse(amount),
                                                  bankName: selectedBank,
                                                  bankCode: selectedBankCode,
                                                  accountName:
                                                      _accountNameController
                                                          .text,
                                                  accountNumber:
                                                      _accountNumberController
                                                          .text);
                                        },
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget showDetails(String lead, String trail, BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lead,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        Text(
          trail,
          style: TextStyle(
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade900,
          ),
        ),
      ],
    ),
  );
}

final saveBeneficiaryProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final selectedBankProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final selectedBankCodeProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
