import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_camera/config.dart';
import 'package:flutter_custom_camera/video_data_model.dart';
import 'package:flutter_custom_camera/widgets/video_bottom_bar.dart';
import 'package:flutter_custom_camera/widgets/video_control_bar.dart';
import 'package:flutter_custom_camera/widgets/video_length_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 8:22 PM
///
///
///


class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>  with WidgetsBindingObserver {
  CameraController controller;
  String imagePath;
  String videoPath;
  BeautyLevel beautyLevel = BeautyLevel.medium;
  VideoSpeed videoSpeed = VideoSpeed.normal;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  CameraLensDirection direction = CameraLensDirection.back;
  List<CameraDescription> cameras = [];
  CameraDescription currentCam;
  List<VideoDatum> videos = [];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      currentCam = cameras.first;
      onNewCameraSelected(cameras.first);
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: controller!=null?Stack(
        children: [
          Transform.scale(
              scale:  controller.value.aspectRatio / deviceRatio,
              child: Center(
                child: AspectRatio(
                  aspectRatio: controller?.value?.aspectRatio,
                  child: CameraPreview(controller), //cameraPreview
                ),
              )
          ),
          Positioned(
            top: 80,
              right: 15,
              child: VideoControlBar(
                onFlip: (){
                  if(currentCam==cameras.first){
                    currentCam = cameras[1];
                    onNewCameraSelected(cameras[1]);
                  }else{
                    currentCam = cameras[0];
                    onNewCameraSelected(cameras[0]);
                  }
                },
                onFLash: (){
                },
              )
          ),
          Positioned(
              bottom: -20,
              right: 0,
              left: 0,
              child: VideoLengthPicker()
          ),
          Positioned(
            bottom: 60,
              right: 0,
              left: 0,
              child: VideoBottomBar(
                isRecording: controller.value.isRecordingVideo,
                isRecordClicked: (){
                  print("hi");
                  if(!controller.value.isRecordingVideo){
                    print("time to record");
                    onVideoRecordButtonPressed();
                  }else{
                    print("time to stop");
                    onStopButtonPressed();
                  }
                },
              )
          ),

        ],
      ):Container(),
    );
  }


  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: true,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        Get.snackbar('Camera error ${controller.value.errorDescription}', '');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      Get.snackbar(e?.toString(), '');
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) setState(() {});
      print('Saving video to $filePath');
      if (filePath != null) Get.snackbar('Saving video to $filePath', '');
    });
  }
  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      Get.snackbar('Video recorded to: $videoPath', '');
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      Get.snackbar('Error: select a camera first.', '');
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      print(e?.toString());
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
      print("video recoring stooped.. saved to"+videoPath);
    } on CameraException catch (e) {
      print(e?.toString());
      return null;
    }
    videos.add(VideoDatum(
      path: videoPath,
      beautyLevel: beautyLevel,
      videoSpeed: videoSpeed
    ));
  }

}
