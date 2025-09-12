import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/widgets/text_field_widgets.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class VirtualAccount extends ConsumerWidget {
  const VirtualAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(fetchUserVirtualAccountProvider);
    return Scaffold(
        appBar: AppBar(
            forceMaterialTransparency: true,
            leadingWidth: 100,
            title: const Text("Bank Transfer"),
            leading: const ZeelBackButton()),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please go to your bank’s website or app and initiate a transfer to the following account details:",
                        style: ShadTheme.of(context).textTheme.muted,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      user.when(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) => Text("Error: $error"),
                          data: (accounts) => ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    thickness: 2,
                                  ),
                              itemCount: accounts!.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const ZeelTextFieldTitle(
                                        text: "Account Name"),
                                    ZeelTextField(
                                      hint: accounts.data![index].accountName,
                                      enabled: false,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const ZeelTextFieldTitle(
                                        text: "Account Number"),
                                    ZeelTextField(
                                      hint: accounts.data![index].accountNumber,
                                      enabled: false,
                                      controller: TextEditingController(
                                          text: accounts
                                              .data![index].accountNumber),
                                      copy: true,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const ZeelTextFieldTitle(text: "Bank Name"),
                                    ZeelTextField(
                                      hint: accounts.data![index].bankName,
                                      enabled: false,
                                    ),
                                  ],
                                );
                              }))
                    ]),
              ),
            ),
          ),
        ));
  }
}
