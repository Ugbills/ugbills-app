import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ugbills/constants/assets/png.dart';
import 'package:ugbills/constants/assets/svg.dart';
import 'package:ugbills/models/api/notifications_model.dart';
import 'package:ugbills/providers/notifications_provider.dart';
import 'package:ugbills/screens/widgets/zeel_button_widget.dart';
import 'package:ugbills/themes/palette.dart';

class Notifications extends ConsumerWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    AsyncValue<NotificationsModel?> notifications =
        ref.watch(fetchUserNotificationsProvider);
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leadingWidth: 100,
          leading: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ZeelBackButton(),
          ),
          title: const Text('Notifications'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: notifications.when(
            data: (data) => ListView.builder(
              shrinkWrap: true,
              itemCount: data!.data!.length,
              itemBuilder: (context, index) {
                return NotificationTile(
                  isDark: isDark,
                  time: data.data![index].date!,
                  description: data.data![index].description!,
                  title: data.data![index].title!,
                );
              },
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
          ),
        ));
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  const NotificationTile({
    super.key,
    required this.isDark,
    required this.title,
    required this.time,
    required this.description,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDark ? ZealPalette.lighterBlack : Colors.white,
      shadowColor: Colors.transparent,
      child: ListTile(
        title: Text(title, style: ShadTheme.of(context).textTheme.h4),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              time,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            )
          ],
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          height: 38,
          width: 38,
          decoration: BoxDecoration(
              color: ShadTheme.of(context).colorScheme.primary,
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
    );
  }
}
