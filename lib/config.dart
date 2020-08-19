///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 8:23 PM
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum CameraType{
  front,
  back,
  none
}

enum VideoSpeed{
  epic,
  slow,
  normal,
  fast,
  lapse
}

enum BeautyLevel{
  none,
  low,
  medium,
  high
}





class SnackBarHelper {
  static void show(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(16));
  }

  static void showLoader(Future onProgress,
      {String title, String message}) async {
    Get.snackbar(title ?? '', message ?? '',
        showProgressIndicator: onProgress != null,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        animationDuration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(16));
    onProgress.catchError((e) {}).whenComplete(() {
      if (Get.isSnackbarOpen) Get.back();
    });
  }
}

