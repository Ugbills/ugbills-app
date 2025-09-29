import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/helpers/storage/theme.dart';
import 'package:ugbills/providers/state/theme_state_provider.dart';
import 'package:ugbills/providers/user_provider.dart';
import 'package:ugbills/screens/user/more/about/about.dart';
import 'package:ugbills/screens/user/more/contact/contact.dart';
import 'package:ugbills/screens/user/more/profile/edit.dart';
import 'package:ugbills/screens/user/more/refer-and-earn/refer_and_earn.dart';
import 'package:ugbills/screens/user/more/security/security.dart';
import 'package:ugbills/screens/user/widgets/zeel_tile.dart';
import 'package:ugbills/themes/palette.dart';

class More extends ConsumerWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var userinfo = ref.watch(fetchMobileUserInformationProvider);

    var darkMode = ref.watch(themeModeProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              userinfo.when(
                data: (user) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: isDark ? ZealPalette.lighterBlack : Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${user!.data!.firstName!} ${user.data!.lastName!}",
                                    style: ShadTheme.of(context)
                                        .textTheme
                                        .small
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text("@${user.data!.username!}"),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text("Transfer Limit: "),
                                    Text(
                                        overflow: TextOverflow.clip,
                                        "₦",
                                        style: ShadTheme.of(context)
                                            .textTheme
                                            .small
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                loading: () => const SizedBox(),
                error: (error, stackTrace) => Text(error.toString()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tiles.length,
                  itemBuilder: (context, index) {
                    if (tiles[index].title.toLowerCase().contains("theme")) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color:
                              isDark ? ZealPalette.lighterBlack : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tiles[index].title,
                                style: ShadTheme.of(context)
                                    .textTheme
                                    .small
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                    )),
                            ShadSwitch(
                                value: darkMode == ThemeMode.dark,
                                onChanged: (value) async => switchTheme(
                                    value: !(darkMode == ThemeMode.dark),
                                    ref: ref)),
                          ],
                        ),
                      );
                    } else {
                      return ZeelListTile(
                          onTap: () {
                            Go.to(tiles[index].route!);
                          },
                          title: tiles[index].title,
                          leadingIcon: tiles[index].leadingIcon);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Tiles> tiles = [
  Tiles(
    title: "Edit Profile",
    leadingIcon: ZeelSvg.userEdit,
    route: EditProfile(),
  ),
  Tiles(
    title: "Refer and Earn",
    leadingIcon: ZeelSvg.refer,
    route: const ReferAndEarn(),
  ),
  Tiles(
    title: "Security Settings",
    leadingIcon: ZeelSvg.settings,
    route: const SecuritySettings(),
  ),
  Tiles(
    title: "Dark Theme",
    leadingIcon: ZeelSvg.settings,
    route: const SecuritySettings(),
  ),
  Tiles(
      title: "Contact Us",
      leadingIcon: ZeelSvg.contact,
      route: const ContactUs()),
  Tiles(
    title: "About Us",
    leadingIcon: ZeelSvg.about,
    route: const AboutUs(),
  ),
  Tiles(title: "Logout", leadingIcon: ZeelSvg.logout),
];

void switchTheme({required bool value, required WidgetRef ref}) async {
  ThemeStorage().update(value);
  ref.refresh(themeModeProvider);
}

class Tiles {
  final String title;
  final String leadingIcon;
  final Widget? route;

  Tiles({
    required this.title,
    required this.leadingIcon,
    this.route,
  });
}
