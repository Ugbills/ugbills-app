import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/providers/state/loading_state_provider.dart';
import 'package:ugbills/screens/auth/create/set_pin.dart';
import 'package:ugbills/screens/user/user.dart';
import 'package:ugbills/screens/widgets/images_widget.dart';
import 'package:ugbills/screens/widgets/texts_widget.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';

class AccountCreatedScreen extends ConsumerWidget {
  const AccountCreatedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leadingWidth: 100,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox.shrink(),
        ),
      ),
      body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ZeeLlogo(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Image.asset("assets/images/saved.png",
                          height: 224.0, width: 224.0),
                      const ZeelTitleText(
                        text: "Awesome!",
                      ),
                      const SizedBox(height: 10.0),
                      const ZeelText(
                          text:
                              "You have successfully created your account, now check it out and proceed with setting up your transaction pin.",
                          center: TextAlign.center),
                      const SizedBox(height: 50.0),

                      const SizedBox(height: 20.0), // Add this line to the code
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZeelAltButton(
                                text: "Set PIN later",
                                onPressed: () {
                                  Go.to(const UserScreen());
                                },
                              ),
                              const SizedBox(height: 20.0),
                              ZeelButton(
                                text: "Continue",
                                isLoading:
                                    ref.watch(isLoadingProvider.notifier).state,
                                onPressed: () =>
                                    Go.to(const SetransactionPin()),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
