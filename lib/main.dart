import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/screens/account_screen.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';

import 'helpers/storage/onboarding.dart';

void main() async {
  await GetStorage.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      navigatorKey: Go.navigatorKey,
      title: 'ZeelPay',
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(

          //We are defining the theme for the app
          brightness: Brightness.light,
          radius: BorderRadius.circular(20),
          colorScheme: const ShadZincColorScheme.light(
            primary: Color(0xf020013a),
            background: Color(0xfffafafa),
          ),
          sheetTheme: ShadSheetTheme(
            radius: BorderRadius.circular(20),
          ),
          textTheme: ShadTextTheme.fromGoogleFont(
            GoogleFonts.cabin,
          )),
      home: OnboardingStorage().get()
          ? const AccountScreen()
          : const Onboarding(),
    );
  }
}
