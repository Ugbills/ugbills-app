// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeelpay/constants/api/endpoints.dart';
import 'package:zeelpay/controllers/user/user_controller.dart';
import 'package:zeelpay/helpers/storage/token.dart';
import 'package:zeelpay/providers/state/loading_state_provider.dart';
import 'package:zeelpay/screens/user/more/account_level/tier-3/kyc_model.dart';
import 'package:zeelpay/screens/user/user.dart';
import 'package:zeelpay/screens/widgets/text_field_widgets.dart';
import 'package:zeelpay/screens/widgets/texts_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_button_widget.dart';
import 'package:zeelpay/screens/widgets/zeel_scrollable_widget.dart';
import 'package:zeelpay/services/http_service.dart';
import 'package:zeelpay/themes/palette.dart';

class CheckQuality extends StatefulWidget {
  final File image;
  final AddressData addressData;
  const CheckQuality(
      {super.key, required this.image, required this.addressData});

  @override
  State<CheckQuality> createState() => _CheckQualityState();
}

class _CheckQualityState extends State<CheckQuality> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Image.file(
              widget.image,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const Spacer(flex: 2),
            const Text(
              "The image should be clear and have your face fully inside the frame before submitting.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(flex: 2),
            ZeelButton(
              text: "Submit",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DocumentUpload(
                            addressData: widget.addressData,
                            selfie: widget.image)));
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                      color: isDark
                          ? ZealPalette.lightPurple
                          : ZealPalette.primaryPurple),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Take a new photo",
                  style: TextStyle(
                      color: isDark ? Colors.white : ZealPalette.primaryPurple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ON FAIL

class SelfieFailed extends StatelessWidget {
  const SelfieFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset("assets/images/zeel-top-logo.png"),
              const Spacer(),
              Image.asset("assets/images/failed.png"),
              const Text(
                "Failed!",
                style: TextStyle(
                  color: ZealPalette.errorRed,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "Please take another selfie with better lighting condition.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(flex: 2),
              ZeelButton(
                text: "Take a new photo",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentUpload extends ConsumerWidget {
  final AddressData addressData;
  final File selfie;
  DocumentUpload({super.key, required this.addressData, required this.selfie});

  final TextEditingController _documentNumberController =
      TextEditingController();
  final TextEditingController _documentTypeController = TextEditingController();
  final TextEditingController _documentTypeIdController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var frontImage = ref.watch(fontImageProvider);
    var backImage = ref.watch(backImageProvider);
    var isloading = ref.watch(isLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const ZeelBackButton(),
        leadingWidth: 100,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: ZeelScrollable(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ZeelTextFieldTitle(text: "Document Type"),
                const SizedBox(height: 6),
                ZeelSelectTextField(
                  hint: "Select Document Type",
                  controller: _documentTypeController,
                  onTap: () {
//bottom sheet
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text("National ID Card (NIN)"),
                                onTap: () {
                                  _documentTypeController.text =
                                      "National ID Card (NIN)";

                                  _documentTypeIdController.text = "nin";
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("International Passport"),
                                onTap: () {
                                  _documentTypeController.text =
                                      "International Passport";
                                  _documentTypeIdController.text =
                                      "internation_passport";
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text("Driver's License"),
                                onTap: () {
                                  _documentTypeController.text =
                                      "Driver's License";
                                  _documentTypeIdController.text =
                                      "driver_license";
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                const ZeelTextFieldTitle(text: "Document Number"),
                const SizedBox(height: 6),
                ZeelTextField(
                  hint: "Enter document number",
                  enabled: true,
                  controller: _documentNumberController,
                ),
                const ZeelTextFieldTitle(text: "Front Image"),
                const SizedBox(height: 6),
                frontImage == null
                    ? UploadDocumentWidget(
                        onTap: () => getImage(ref, fontImageProvider, context),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.file(
                          frontImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(height: 20),
                const ZeelTextFieldTitle(text: "Back Image"),
                const SizedBox(height: 6),
                backImage == null
                    ? UploadDocumentWidget(
                        onTap: () => getImage(ref, backImageProvider, context),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: double.infinity,
                        child: Image.file(
                          backImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(height: 20),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ZeelButton(
                        text: "Submit",
                        isLoading: isloading,
                        onPressed: () async {
                          ref.read(isLoadingProvider.notifier).state = true;
                          var selfieUrl = await uploadImage(selfie);
                          var frontImageUrl = await uploadImage(frontImage!);
                          var backImageUrl = await uploadImage(backImage!);

                          if (selfieUrl == null ||
                              frontImageUrl == null ||
                              backImageUrl == null) {
                            ref.read(isLoadingProvider.notifier).state = false;
                            return;
                          } else {
                            ref
                                .read(userControllerProvider.notifier)
                                .submitAddress(
                                    address: addressData,
                                    frontImage: frontImageUrl,
                                    backImage: backImageUrl,
                                    selfie: selfieUrl,
                                    documentType:
                                        _documentTypeIdController.text,
                                    documentNumber:
                                        _documentNumberController.text,
                                    context: context,
                                    ref: ref);
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future getImage(WidgetRef ref, AutoDisposeStateProvider<File?> imageProvider,
    BuildContext context) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  ref.read(imageProvider.notifier).state = File(pickedImage!.path);
}

final fontImageProvider = StateProvider.autoDispose<File?>((ref) {
  return null;
});

final backImageProvider = StateProvider.autoDispose<File?>((ref) {
  return null;
});

class UploadDocumentWidget extends StatelessWidget {
  final void Function()? onTap;
  const UploadDocumentWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: const Center(
          child: Text(
            "Upload Document",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

/// ON SUCCESS

class SelfieSuccess extends StatelessWidget {
  const SelfieSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/images/zeel-top-logo.png"),
              const Spacer(),
              Image.asset("assets/images/congrats.png"),
              const ZeelTitleText(text: "Congratulations!"),
              const Text(
                "Your identity verification request has been submitted successfully for a tier 3 upgrade. ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(flex: 3),
              ZeelButton(
                text: "Back",
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const UserScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String?> uploadImage(File image) async {
  final HttpService httpService = HttpService();
  final token = await TokenStorage().getToken();

  var response = await httpService.uploadFileRequest(
    fileName: DateTime.now().toString().split(" ").join("_"),
    Endpoints.userDocUpload,
    file: image,
    key: "file",
    headers: {'ZEEL-SECURE-KEY': token},
  );

  if (response.statusCode == 200) {
    return response.data['public_url'];
  } else {
    return null;
  }
}
