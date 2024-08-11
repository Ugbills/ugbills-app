// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/controllers/user/user_controller.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';
// import 'package:image_picker/image_picker.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ref) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);

        UserController()
            .updateProfilePicture(image: _image!, ref: ref, context: context);
      }
    });
  }

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(fetchUserInformationProvider);
    var isLoading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Profile", style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
      ),
      body: SafeArea(
          child: user.when(
        data: (user) => Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(top: 24),
                children: [
                  Consumer(
                    builder: (context, ref, child) => GestureDetector(
                      onTap: () async => getImage(ref),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    _image!,
                                    height: 130,
                                    width: 130,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ShadAvatar(
                                  size: const Size(100, 100),
                                  user!.data!.profilePicture!.isNotEmpty
                                      ? user.data!.profilePicture!
                                      : ZeelPng.avatar,
                                  fit: BoxFit.cover,
                                ),
                          const Icon(Icons.camera_alt_outlined,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const ZeelTextFieldTitle(text: "Username"),
                  ZeelTextField(
                    enabled: true,
                    hint: user!.data!.username,
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: userNameController,
                  ),
                  const ZeelTextFieldTitle(text: "Full Name"),
                  ZeelTextField(
                    enabled: false,
                    hint: "${user.data!.firstName!} ${user.data!.lastName!}",
                  ),
                  const ZeelTextFieldTitle(text: "Email Address"),
                  ZeelTextField(
                    enabled: false,
                    hint: user.data!.email!,
                  ),
                  const ZeelTextFieldTitle(text: "Phone Number"),
                  ZeelTextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    enabled: true,
                    hint: user.data!.phoneNumber!,
                    controller: phoneNumberController,
                  ),
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
              child: ZeelButton(
                text: "Update",
                isLoading: isLoading,
                onPressed: userNameController.text.isNotEmpty &&
                        phoneNumberController.text.isNotEmpty &&
                        phoneNumberController.text.length == 11 &&
                        userNameController.text.length > 3
                    ? () async {
                        await UserController().updateProfile(
                          phoneNumber: phoneNumberController.text,
                          userName: userNameController.text,
                          ref: ref,
                          context: context,
                        );
                      }
                    : null,
              ),
            ),
          ],
        ),
        loading: () => const SizedBox(),
        error: (error, stackTrace) => Text(error.toString()),
      )),
    );
  }
}
