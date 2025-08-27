// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zeelpay/helpers/snacks/snacks_helper.dart';

class TransactionHelper {
  // Future<String> saveReceipt(
  //     {required Widget receipt,
  //     required BuildContext context,
  //     required ScreenshotController controller}) async {
  //   try {
  //     var receiptFile =
  //         await controller.captureFromWidget(receipt, context: context);

  //     var permission = await Permission.storage.request().isGranted;
  //     if (permission) {
  //       final timeNow = DateTime.now()
  //           .toIso8601String()
  //           .replaceAll(".", "-")
  //           .replaceAll(":", "-");
  //       await ImageGallerySaver.saveImage(receiptFile,
  //           quality: 100, name: "TransactionReceipt_$timeNow");

  //       successSnack(context, 'Receipt saved to gallery');
  //       return "success";
  //     } else {
  //       errorSnack(context, "Storage Permission denied");
  //       return "failed";
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     return "failed";
  //   }
  // }

  Future<void> shareReceipt(
      {required Widget receipt,
      required BuildContext context,
      required ScreenshotController controller}) async {
    try {
      var receiptFile =
          await controller.captureFromWidget(receipt, context: context);
      var permission = await Permission.storage.request().isGranted;
      if (permission) {
        final directory = await getApplicationDocumentsDirectory();
        final image = File('${directory.path}/image.png');
        await image.writeAsBytes(receiptFile);
        await Share.shareXFiles([XFile(image.path)]);
      } else {
        errorSnack(context, "Storage Permission denied");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
