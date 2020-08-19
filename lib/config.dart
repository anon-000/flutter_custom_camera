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

List<VideoSpeed> availableSpeeds = [VideoSpeed.epic, VideoSpeed.slow, VideoSpeed.normal, VideoSpeed.fast, VideoSpeed.lapse];
List<String> speedOptions = ['Epic', 'Slow', 'Normal', 'Fast', 'Lapse'];
List<BeautyLevel> availableBeautyLevels= [BeautyLevel.none,BeautyLevel.low, BeautyLevel.medium, BeautyLevel.high];
List<String> beautyOptions = ['None','Low', 'Medium', 'High'];
List<String> availableTimerDurations = ['None','5s', '10s', '15s', '20s'];
List<int> timerOptions = [0,5,10,15,20];



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

