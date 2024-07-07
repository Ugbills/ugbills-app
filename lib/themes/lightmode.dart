import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lightTheme = FlexThemeData.light(
  scaffoldBackground: const Color(0xfffafafa),
  primary: const Color(0xf020013a),
  secondary: const Color(0xfffafafa),
  background: const Color(0xfffafafa),
  primaryContainer: const Color(0xfffafafa),
  surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
  blendLevel: 20,
  tabBarStyle: FlexTabBarStyle.forBackground,
  tooltipsMatchBackground: true,
  appBarBackground: const Color(0xfffafafa),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.grey[600]),
    bodyMedium: TextStyle(color: Colors.grey[600]),
    titleMedium: const TextStyle(color: Colors.black),
    titleSmall: const TextStyle(color: Colors.black),
    displayLarge: const TextStyle(color: Colors.black),
    displayMedium: const TextStyle(color: Colors.black),
    displaySmall: const TextStyle(color: Colors.black),
    headlineMedium: const TextStyle(color: Colors.black),
    headlineSmall: const TextStyle(color: Colors.black),
    titleLarge: const TextStyle(color: Colors.black),
  ),
  subThemesData: const FlexSubThemesData(
    inputDecoratorFillColor: Color(0xfffdfdfd),
    blendOnLevel: 20,
    blendOnColors: false,
    defaultRadius: 20,
    bottomSheetRadius: 16.0,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorIsFilled: false,
    inputDecoratorRadius: 15,
    inputDecoratorUnfocusedHasBorder: true,
    inputDecoratorBorderWidth: 0.2,
    inputDecoratorFocusedBorderWidth: 0.5,
    navigationBarHeight: 68.0,
  ),
  keyColors: const FlexKeyColors(
    useTertiary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.montserrat().fontFamily,
);
