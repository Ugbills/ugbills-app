import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

errorSnack(context, message) {
  showTopSnackBar(
    Overlay.of(context),
    Material(
      color: Colors.transparent,
      child: AwesomeSnackbarContent(
        title: "Error",
        message: message,
        contentType: ContentType.failure,
      ),
    ),
    displayDuration: const Duration(milliseconds: 500),
  );
}

successSnack(context, message) async {
  showTopSnackBar(
    Overlay.of(context),
    Material(
      color: Colors.transparent,
      child: AwesomeSnackbarContent(
        title: "Success",
        message: message,
        contentType: ContentType.success,
      ),
    ),
    displayDuration: const Duration(milliseconds: 500),
  );
}

// zappySuccessSnack(
//     {required BuildContext context,
//     required String message,
//     String? title = "Success"}) {
//   showTopSnackBar(
//     Overlay.of(context),
//     Material(
//       child: AwesomeSnackbarContent(
//         title: title!,
//         message: message,
//         contentType: ContentType.success,
//       ),
//     ),
//   );
// }

// zappyErrorSnack(
//     {required BuildContext context,
//     required String message,
//     String? title = "Oh Snap!"}) {
//   showTopSnackBar(
//     Overlay.of(context),
//     const CustomSnackBar.success(
//       message: "Good job, your release is successful. Have a nice day",
//     ),
//   );
// }

// zappyWarningSnack(
//     {required BuildContext context,
//     required String message,
//     String? title = "Warning!"}) {
//   final snackBar = SnackBar(
//     /// need to set following properties for best effect of awesome_snackbar_content
//     elevation: 0,
//     behavior: SnackBarBehavior.floating,
//     duration: const Duration(seconds: 10),
//     backgroundColor: Colors.transparent,
//     content: AwesomeSnackbarContent(
//       title: title!,
//       message: message,

//       /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//       contentType: ContentType.warning,
//     ),
//   );

//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(snackBar);
// }

// zappyHelpSnack(
//     {required BuildContext context,
//     required String message,
//     String? title = "Hi There!"}) {
//   final snackBar = SnackBar(
//     /// need to set following properties for best effect of awesome_snackbar_content
//     elevation: 0,
//     duration: const Duration(seconds: 30),
//     behavior: SnackBarBehavior.floating,
//     backgroundColor: Colors.transparent,
//     content: AwesomeSnackbarContent(
//       title: title!,
//       message: message,

//       /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//       contentType: ContentType.help,
//     ),
//   );

//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(snackBar);
// }
