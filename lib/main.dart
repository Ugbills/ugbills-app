import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/firebase_options.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/providers/state/theme_state_provider.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/account_screen.dart';
import 'package:zeelpay/screens/auth/bio.dart';
import 'package:zeelpay/screens/auth/create/set_pin.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';

import 'helpers/storage/onboarding.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  //remove splashscreen
  void initialization() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themMode = ref.watch(themeModeProvider);

    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(seconds: 60),
        invalidateSessionForUserInactivity: const Duration(seconds: 300));
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) async {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        if (await TokenStorage().isAuthenticated()) {
          ref.refresh(fetchUserInformationProvider);
          ref.read(fetchUserInformationProvider).whenData((value) => {
                if (value!.data!.pin! != "")
                  {Go.to(const BiometricsLoginScreen())}
                else
                  {Go.to(const SetransactionPin())}
              });
        }
      }
    });

    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: ShadApp(
        navigatorKey: Go.navigatorKey,
        title: 'ZeelPay',
        debugShowCheckedModeBanner: false,
        themeMode: themMode,
        darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            radius: BorderRadius.circular(10),
            colorScheme: const ShadZincColorScheme.dark(),
            sheetTheme: ShadSheetTheme(
              radius: BorderRadius.circular(20),
            ),
            textTheme: ShadTextTheme.fromGoogleFont(
              GoogleFonts.cabin,
            )),
        theme: ShadThemeData(
            //We are defining the theme for the app
            brightness: Brightness.light,
            radius: BorderRadius.circular(10),
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
            ? FutureBuilder(
                future: TokenStorage().isAuthenticated(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return snapshot.data!
                        ? const BiometricsLoginScreen()
                        : const AccountScreen();
                  }
                  return const Onboarding();
                })
            : const Onboarding(),
      ),
    );
  }
}
