import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/controllers/transfer/transfer_controller.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/widgets/authenticate_transaction.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class SendByUsername extends ConsumerStatefulWidget {
  const SendByUsername({super.key});

  @override
  ConsumerState<SendByUsername> createState() => _SendByUsernameState();
}

class _SendByUsernameState extends ConsumerState<SendByUsername> {
  String? avatar;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final amount = ModalRoute.of(context)!.settings.arguments as String;

    //show loading dialog
    Dialog alert = const Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(child: CircularProgressIndicator()));

    ref.listen(isLoadingProvider, (previous, next) {
      if (next == true) {
        showDialog(
            barrierColor: const Color.fromARGB(39, 0, 0, 0),
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return alert;
            });
      }
      if (next == false) {
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send by Username'),
        forceMaterialTransparency: true,
        leadingWidth: 100,
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ZeelTextFieldTitle(text: "Amount"),
              ZeelTextField(hint: "₦$amount", enabled: false),
              const ZeelTextFieldTitle(text: "Username"),
              ZeelTextField(
                hint: "@",
                enabled: true,
                controller: userNameController,
                onChanged: (value) {
                  setState(() {
                    nameController.clear();
                  });
                },
                onEditingComplete: () async {
                  if (userNameController.text.isNotEmpty) {
                    ref.read(isLoadingProvider.notifier).state = true;
                    await validateUgBillsAccount(
                            username: userNameController.text)
                        .then((value) {
                      ref.read(isLoadingProvider.notifier).state = false;
                      if (value != null) {
                        setState(() {
                          nameController.text = value.data!.fullName!;
                          avatar = value.data!.avatar!;
                        });
                      }
                    });
                  }
                },
              ),
              const ZeelTextFieldTitle(text: "Full Name"),
              ZeelTextField(
                hint: "",
                enabled: false,
                controller: nameController,
              ),
              const ZeelTextFieldTitle(text: "Note (Optional)"),
              ZeelTextField(
                hint: "Add a note",
                enabled: true,
                controller: noteController,
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: ZeelButton(
                  onPressed: nameController.text.isEmpty
                      ? null
                      : () {
                          Go.to(ConfirmTransaction(
                            onPinComplete: (pin) => transferUgBills(
                                context: context,
                                note: noteController.text,
                                pin: pin!,
                                ref: ref,
                                username: userNameController.text,
                                amount:
                                    double.parse(amount.replaceAll(",", "")),
                                avatar: avatar!),
                          ));
                        },
                  text: "Send",
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

// Widget
