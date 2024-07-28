import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/screens/onboarding/onboarding.dart';
import 'package:zeelpay/screens/user/more/profile/updated.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';
// import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // File? _image;
  // final picker = ImagePicker();

  Future getImage() async {
    // final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // if (pickedImage != null) {
      // _image = File(pickedImage.path);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Fund Your Account",
            style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(top: 24),
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(100),
                      //   child: Image.file(
                      //     _image!,
                      //     height: 130,
                      //     width: 130,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      SizedBox(
                          height: 120,
                          child: Image.asset(
                            "assets/images/lady-img.png",
                            fit: BoxFit.cover,
                          )),
                      const Icon(Icons.camera_alt_outlined,
                          color: Colors.white),
                    ],
                  ),
                  inputeField("Username"),
                  inputeField("Full Name", readOnly: true),
                  inputeField("Email Address", readOnly: true),
                  inputeField("Phone Number"),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: const Text(
                "Delete Account",
                style: TextStyle(
                    color: ZealPalette.errorRed, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0).copyWith(top: 12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProfileUpdated()));
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Update"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget inputeField(String title, {bool readOnly = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title),
      TextField(
        readOnly: readOnly,
        decoration: InputDecoration(
          filled: readOnly,
          fillColor: ZealPalette.greyColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
      const SizedBox(height: 12),
    ],
  );
}
