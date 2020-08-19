import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_camera/config.dart';
import 'package:flutter_custom_camera/saved_video_page.dart';
import 'package:flutter_custom_camera/video_data_model.dart';
import 'package:flutter_custom_camera/widgets/custom_progress_indicator.dart';
import 'package:flutter_custom_camera/widgets/options_display_widget.dart';
import 'package:flutter_custom_camera/widgets/video_bottom_bar.dart';
import 'package:flutter_custom_camera/widgets/video_control_bar.dart';
import 'package:get/get.dart';
import 'package:lamp/lamp.dart';
import 'package:path_provider/path_provider.dart';

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
  BeautyLevel beautyLevel = BeautyLevel.none;
  VideoSpeed videoSpeed = VideoSpeed.normal;
  List<CameraDescription> cameras = [];
  CameraDescription currentCam;
  List<VideoDatum> videos = [];
  double currentOptionOpacity = 0;
  Widget currentOptionWidget;
  List<Widget> optionChildren = [];
  int currentTimerDuration = 5;
  int videoLength = 15;
  Timer _timer;
  int timerCounter = 5;
  double timerOpacity = 0;
  Timer _videoTimer;
  int videoTimeCounter = 0;
  bool hasFlash = false, isFlashOn = false;
  List<int> lastVideoTimeCounter = [];
  List<VideoSpeed> availableSpeeds = [VideoSpeed.epic, VideoSpeed.slow, VideoSpeed.normal, VideoSpeed.fast, VideoSpeed.lapse];
  List<String> speedOptions = ['Epic', 'Slow', 'Normal', 'Fast', 'Lapse'];
  List<BeautyLevel> availableBeautyLevels= [BeautyLevel.none,BeautyLevel.low, BeautyLevel.medium, BeautyLevel.high];
  List<String> beautyOptions = ['None','Low', 'Medium', 'High'];
  List<String> availableTimerDurations = ['None','5s', '10s', '15s', '20s'];
  List<int> timerOptions = [0,5,10,15,20];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
    initializeOptions();

  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _videoTimer?.cancel();
    super.dispose();
  }
  ///Timer
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        setState(
              () {
            if (timerCounter < 1) {
              timerOpacity = 0;
              timer.cancel();
            } else {
              timerOpacity = 1;
              timerCounter = timerCounter - 1;
            }
          },
        );
      },
    );
  }
  void startVideoTimer() {
    const oneSec = const Duration(seconds: 1);
    _videoTimer = Timer.periodic(
      oneSec,
          (Timer timer) {
        setState(
              () {
            if (videoTimeCounter == 15) {
              timer.cancel();
              onStopButtonPressed();
            } else {
              videoTimeCounter = videoTimeCounter + 1;
            }
          },
        );
      },
    );
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      currentCam = cameras.first;
      hasFlash = await Lamp.hasLamp;
      onNewCameraSelected(cameras.first);
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  void initializeOptions(){
    optionChildren = [
      videoSpeedSelection(),
      beautySelection(),
      timerSelection()
    ];
    currentOptionWidget = optionChildren[0];
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
                  child: CameraPreview(controller,), //cameraPreview
                ),
              )
          ),
          Positioned(
            top: 80,
              right: 15,
              child: VideoControlBar(
                isFlashOn: isFlashOn,
                onFlip: (){
                  if(currentCam==cameras.first){
                    currentCam = cameras[1];
                    onNewCameraSelected(cameras[1]);
                  }else{
                    currentCam = cameras[0];
                    onNewCameraSelected(cameras[0]);
                  }
                },
                onSpeed: (){
                  setState(() {
                    currentOptionWidget = videoSpeedSelection();
                    currentOptionOpacity = 1;
                  });
                },
                onBeauty: (){
                  setState(() {
                    currentOptionWidget = beautySelection();
                    currentOptionOpacity = 1;
                  });
                },
                onTimer: (){
                  setState(() {
                    currentOptionWidget = timerSelection();
                    currentOptionOpacity = 1;
                  });
                },
                onFLash: (){
                  if(hasFlash){
                    if(isFlashOn){
                      Lamp.turnOff();
                    }else{
                      Lamp.turnOn();
                    }
                  }{
                    SnackBarHelper.show("Error", "You have no flash available");
                  }
                },
              )
          ),
          Positioned(
            bottom: 60,
              right: 0,
              left: 0,
              child: VideoBottomBar(
                isRecording: controller.value.isRecordingVideo,
                isRecordClicked: (){
                  print("hi");
                  currentOptionOpacity = 0;
                  if(!controller.value.isRecordingVideo){
                    print("time to record");
                    if(videoTimeCounter!=15){
                      onVideoRecordButtonPressed();
                    }
                  }else{
                    print("time to stop");
                    onStopButtonPressed();
                  }
                },
                onNext: (){
                  print("clicked");
                  print(videos.length.toString());
                  for(VideoDatum video in videos){
                    print('path to video :' + video.path);
                  }
                  Get.to(SavedVideoPage(videos: videos,));
                },
                onDelete: (){
                  String path = videos.elementAt(videos.length-1).path;
                  final dir = Directory(path);
                  dir.deleteSync(recursive: true);
                  videos.removeLast();
                  print("deleted");
                  print("last time counter :"+lastVideoTimeCounter.toString());
                  print("recent time counter :"+videoTimeCounter.toString());
                  setState(() {
                    videoTimeCounter = lastVideoTimeCounter.elementAt(lastVideoTimeCounter.length-1);
                    lastVideoTimeCounter.removeLast();
                  });
                  SnackBarHelper.show("Deleted", "Last Clip Deleted Successfully");
                },
              )
          ),
          Positioned(
            bottom: 160,
              right: 0,
              left: 0,
              child: AnimatedOpacity(
                opacity: currentOptionOpacity,
                duration: Duration(milliseconds: 600),
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                  child: currentOptionWidget,
                ),
              )
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 40,
            child: CustomProgressIndicator(
              valueInPercent: (videoTimeCounter/videoLength)*100,
              max: videoLength,
              partitions: lastVideoTimeCounter,
            ),
          ),
          Positioned(
            right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(child: Center(
                  child: AnimatedOpacity(
                    opacity: timerOpacity,
                      duration: Duration(milliseconds: 300),
                      child: Text(timerCounter.toString(), style: TextStyle(fontSize: 35, color: Colors.white),))
              ))
          ),
          Positioned(
            top: 30,
              left: 10,
              child: Text(videoTimeCounter.toString(), style: TextStyle(fontSize: 35, color: Colors.white))
          )

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
        print('Camera error ${controller.value.errorDescription}');
      }
    });
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e?.toString());
    }
    if (mounted) {
      setState(() {});
    }
  }

  void onVideoRecordButtonPressed() {
    setState(() {
      timerCounter = currentTimerDuration;
      lastVideoTimeCounter.add(videoTimeCounter) ;
    });
    startTimer();
    Future.delayed(Duration(seconds: timerCounter)).then((value){
      startVideoTimer();
      startVideoRecording().then((String filePath) {
        if (mounted) setState(() {});
        print('Saving video to $filePath');
        if (filePath != null) print('Saving video to $filePath');
      });
    });
  }
  void onStopButtonPressed() {
    _videoTimer.cancel();
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      SnackBarHelper.show('Video recorded to: $videoPath', '');
      VideoDatum data = VideoDatum(
          path: videoPath,
          beautyLevel: beautyLevel,
          videoSpeed: videoSpeed,
        videoLength: videoTimeCounter-lastVideoTimeCounter.last
      );
      videos.add(data);
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      SnackBarHelper.show('Error: select a camera first.', '');
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
      print("video recording stooped.. saved to"+videoPath);
    } on CameraException catch (e) {
      print(e?.toString());
      return null;
    }

  }

  Widget videoSpeedSelection(){
    return OptionsDisplayWidget(
      currentIndex: availableSpeeds.indexOf(videoSpeed),
      onTap: (index){
        setState(() {
          videoSpeed = availableSpeeds[index];
          print("video speed :"+videoSpeed.toString());
          print("spped index :" +availableSpeeds.indexOf(videoSpeed).toString());
          currentOptionWidget = videoSpeedSelection();
        });
      },
      data: speedOptions,
    );
  }

  Widget beautySelection(){
    return OptionsDisplayWidget(
      currentIndex: availableBeautyLevels.indexOf(beautyLevel),
      onTap: (index){
        setState(() {
          beautyLevel = availableBeautyLevels[index];
          print("beauty selected : "+beautyLevel.toString());
          print('index'+availableBeautyLevels.indexOf(beautyLevel).toString());
          currentOptionWidget = beautySelection();
        });
      },
      data: beautyOptions,
    );
  }
  Widget timerSelection(){
    return OptionsDisplayWidget(
      currentIndex: timerOptions.indexOf(currentTimerDuration),
      onTap: (index){
        setState(() {
          currentTimerDuration = timerOptions[index];
          timerCounter = currentTimerDuration;
          print('current timer :'+currentTimerDuration.toString());
          print('timer index :' +timerOptions.indexOf(currentTimerDuration).toString());
          currentOptionWidget = timerSelection();
        });
      },
      data: availableTimerDurations,
    );
  }

}

