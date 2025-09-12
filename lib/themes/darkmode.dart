import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

var darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.blue,
  scaffoldBackground: FlexColor.darkSurface,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,

  blendLevel: 15,
  appBarOpacity: 0.90,
  tabBarStyle: FlexTabBarStyle.forBackground,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData(
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
  // To use the playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.montserrat().fontFamily,
);
