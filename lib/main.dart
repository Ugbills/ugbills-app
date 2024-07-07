import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/screens/account_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      title: 'ZeelPay',
      theme: ShadThemeData(

          //We are defining the theme for the app
          brightness: Brightness.light,
          colorScheme:
              const ShadZincColorScheme.light(primary: Color(0xf020013a)),
          textTheme: ShadTextTheme.fromGoogleFont(
            GoogleFonts.cabin,
          )),
      home: const AccountScreen(),
    );
  }
}
