import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:short_navigation/short_navigation.dart';
import 'package:zeelpay/constants/assets/png.dart';
import 'package:zeelpay/controllers/user/user_controller.dart';
import 'package:zeelpay/helpers/forms/validators.dart';
import 'package:zeelpay/providers/user_provider.dart';
import 'package:zeelpay/repository/auth_repository.dart';
import 'package:zeelpay/screens/widgets/authenticate_transaction.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/themes/palette.dart';

class EditProfile extends HookConsumerWidget {
  EditProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final phoneNumberController = useTextEditingController();
    final userNameController = useTextEditingController();

    final image = ref.watch(imageProvider);
    var user = ref.watch(fetchUserInformationProvider);

    final pendingUpdate = useState<Future<void>?>(null);

    var isLoading = useFuture(pendingUpdate.value).connectionState ==
        ConnectionState.waiting;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        title: Text("Profile", style: ShadTheme.of(context).textTheme.h3),
        leading: const ZeelBackButton(),
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
          child: user.when(
        data: (user) => Column(
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24)
                      .copyWith(top: 24),
                  children: [
                    GestureDetector(
                      onTap: () async => getImage(ref, context),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    image,
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
                    const SizedBox(height: 12),
                    const ZeelTextFieldTitle(text: "Username"),
                    ZeelTextField(
                      validator: usernameValidator,
                      enabled: true,
                      hint: user!.data!.username,
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
                      validator: phoneNumberValidator,
                      enabled: true,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      hint: user.data!.phoneNumber!,
                      controller: phoneNumberController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0).copyWith(top: 12),
              child: ZeelButton(
                  text: "Update",
                  isLoading: isLoading,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final future = ref
                          .read(userControllerProvider.notifier)
                          .updateProfile(
                              ref: ref,
                              phoneNumber: phoneNumberController.text,
                              userName: userNameController.text,
                              context: context)
                          .then((value) {
                        ref.refresh(fetchUserInformationProvider);
                      });

                      pendingUpdate.value = future;
                    }
                  }),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Wrap(
                        children: [
                          Text(
                            "Delete Account",
                            style: ShadTheme.of(context)
                                .textTheme
                                .h1
                                .copyWith(fontSize: 16),
                          ),
                          Container(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 30.0),
                            child: Text(
                              "Do you wish to permanently delete your account with us?",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            height: 40,
                          ),
                          ZeelAltButton(
                            text: "Yes, Proceed",
                            onPressed: () {
                              Go.to(ConfirmTransaction(
                                onPinComplete: (pin) async => AuthRepository()
                                    .deleteAccount(
                                        pin: pin!, context: context, ref: ref),
                              ));
                            },
                          ),
                          Container(
                            height: 20,
                          ),
                          ZeelButton(
                            text: "No",
                            onPressed: () {
                              Go.back();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text(
                "Delete Account",
                style: TextStyle(
                    color: ZealPalette.errorRed, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        loading: () => const SizedBox(),
        error: (error, stackTrace) => Text(error.toString()),
      )),
    );
  }

  Future getImage(WidgetRef ref, BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final imagetoupload = File(pickedImage!.path);
    ref.read(imageProvider.notifier).state = File(pickedImage.path);

    if (context.mounted) {
      await ref
          .read(userControllerProvider.notifier)
          .updateProfilePicture(image: imagetoupload, context: context);
    }
  }

  final imageProvider = StateProvider.autoDispose<File?>((ref) {
    return null;
  });
}
