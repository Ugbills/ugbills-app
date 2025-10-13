import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/screens/user/home/home.dart';
import 'package:ugbills/screens/user/more/more.dart';
import 'package:ugbills/screens/user/pay/pay.dart';
import 'package:ugbills/themes/palette.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentScreenProvider);
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ZealPalette.scaffoldBlack : null,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) =>
              ref.read(currentScreenProvider.notifier).state = value,
          currentIndex: currentIndex,
          selectedItemColor: ShadTheme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          selectedLabelStyle: TextStyle(
            color: ShadTheme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          items: [
            BottomNavigationBarItem(
              icon: ShadImage.square(
                currentIndex == 0 ? ZeelPng.home : ZeelPng.home,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ShadImage.square(
                ZeelSvg.pay,
                size: 30,
                color: currentIndex == 1
                    ? ShadTheme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              label: 'Pay',
            ),
            BottomNavigationBarItem(
              icon: ShadImage.square(
                ZeelSvg.accountLevels,
                size: 30,
                color: currentIndex == 2
                    ? ShadTheme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              label: 'Profile',
            ),
          ]),
      body: _screens[currentIndex],
    );
  }
}

List<Widget> _screens = const [
  DashBoardScreen(),
  Pay(),
  More(),
];

final currentScreenProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
