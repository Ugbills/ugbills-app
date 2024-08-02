import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/png.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/user/card/card.dart';
import 'package:zeelpay/screens/user/home/home.dart';
import 'package:zeelpay/screens/user/more/more.dart';
import 'package:zeelpay/screens/user/pay/pay.dart';
import 'package:zeelpay/screens/user/trade/trade.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentScreenProvider);
    return Scaffold(
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
                currentIndex == 0 ? ZeelPng.home : ZeelPng.homeInactive,
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
                ZeelSvg.trade,
                size: 30,
                color: currentIndex == 2
                    ? ShadTheme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              label: 'Trade',
            ),
            BottomNavigationBarItem(
              icon: ShadImage.square(
                ZeelSvg.card,
                size: 30,
                color: currentIndex == 3
                    ? ShadTheme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              label: 'Card',
            ),
            BottomNavigationBarItem(
              icon: ShadImage.square(
                ZeelSvg.more,
                size: 30,
                color: currentIndex == 4
                    ? ShadTheme.of(context).colorScheme.primary
                    : Colors.grey,
              ),
              label: 'More',
            ),
          ]),
      body: _screens[currentIndex],
    );
  }
}

List<Widget> _screens = const [
  DashBoardScreen(),
  Pay(),
  TradeScreen(),
  CardScreen(),
  More(),
];

final currentScreenProvider = StateProvider<int>((ref) {
  return 0;
});
