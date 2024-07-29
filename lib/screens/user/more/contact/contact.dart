import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/svg.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Contact Us", style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const ZeelTitleText(text: "We are here to help"),
          const Text(
            "Have any complaints, concerns or issues? our customer support is always here to fix it. Reach out to us through any of these channels.",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          contactTiles(
            ZeelSvg.call,
            "Call Us",
            "Business hours everyday",
            () {},
          ),
          contactTiles(
            ZeelSvg.email,
            "Email Us",
            "Reach out to us via email",
            () {},
          ),
          contactTiles(
            ZeelSvg.chat,
            "Chat with Us",
            "Start a live conversation",
            () {},
          ),
          contactTiles(
            ZeelSvg.instagram,
            "Instagram",
            "Connect with us via Instagram",
            () {},
          ),
          contactTiles(
            ZeelSvg.x,
            "X",
            "Connect with us via X",
            () {},
          ),
          contactTiles(
            ZeelSvg.facebook,
            "Facebook",
            "Connect with us via Facebook",
            () {},
          ),
        ],
      ),
    );
  }
}

Widget contactTiles(
    String imagePath, String title, String subtitle, Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ShadImage.square(
                imagePath,
                size: 42,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZeelTextFieldTitle(text: title),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    ),
  );
}
