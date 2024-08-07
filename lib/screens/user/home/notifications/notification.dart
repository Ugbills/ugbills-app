import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ZeelBackButton(),
        ),
        title: const Text('Notifications'),
      ),
      body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Card(
                        color: isDark ? ZealPalette.lighterBlack : Colors.white,
                        shadowColor: Colors.transparent,
                        child: ListTile(
                          title: Text('Deposited',
                              style: ShadTheme.of(context).textTheme.h4),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'You have successfully deposited ₦10,000 in your account',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: isDark ? Colors.grey : Colors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "10 min",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? Colors.grey : Colors.white,
                                ),
                              )
                            ],
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                                color:
                                    ShadTheme.of(context).colorScheme.primary,
                                shape: BoxShape.circle),
                            child: const ShadImage.square(
                              ZeelPng.bell,
                              size: 22,
                              fit: BoxFit.contain,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const ShadImage.square(
                                ZeelSvg.redDot,
                                size: 15,
                              ),
                              const Spacer(),
                              ShadImage.square(
                                ZeelSvg.downArrow,
                                size: 24,
                                color: isDark ? Colors.grey : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )))
          ]),
    );
  }
}
