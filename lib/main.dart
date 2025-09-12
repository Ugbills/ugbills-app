import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/firebase_options.dart';
import 'package:ugbills/helpers/storage/token.dart';
import 'package:ugbills/providers/state/theme_state_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/account_screen.dart';
import 'package:ugbills/screens/auth/bio.dart';
import 'package:ugbills/screens/auth/create/set_pin.dart';
import 'package:ugbills/screens/onboarding/onboarding.dart';

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
        title: 'UG Bills',
        debugShowCheckedModeBanner: false,
        themeMode: themMode,
        darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            radius: BorderRadius.circular(10),
            colorScheme: const ShadZincColorScheme.dark(),
            sheetTheme: ShadSheetTheme(
              radius: BorderRadius.circular(20),
            ),
            textTheme: ShadTextTheme(family: 'Geist')),
        theme: ShadThemeData(
            //We are defining the theme for the app
            brightness: Brightness.light,
            radius: BorderRadius.circular(10),
            colorScheme: const ShadZincColorScheme.light(
              primary: Color(0xff1C41AB),
              background: Color(0xfffafafa),
            ),
            sheetTheme: ShadSheetTheme(
              radius: BorderRadius.circular(20),
            ),
            textTheme: ShadTextTheme(family: 'Geist')),
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
