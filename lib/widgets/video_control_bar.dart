import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 8:45 PM
///
///

class VideoControlBar extends StatelessWidget {
  final Function onFlip;
  final Function onFLash;
  final Function onSpeed;
  final Function onBeauty;
  final Function onTimer;
  final bool isFlashOn;
  VideoControlBar({this.onFlip, this.onFLash,this.onBeauty, this.onSpeed, this.onTimer, this.isFlashOn=false});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(Icons.switch_camera), onPressed: () {
          onFlip();
        }, color: Colors.white,),
        Text("Flip", style: TextStyle(color: Colors.white),),
        IconButton(icon: Icon(Icons.directions_run), onPressed: () {
          onSpeed();
        }, color: Colors.white),
        Text("Speed",  style: TextStyle(color: Colors.white)),
        IconButton(icon: Icon(Icons.brush), onPressed: () {
          onBeauty();
        }, color: Colors.white),
        Text("Beauty",  style: TextStyle(color: Colors.white)),
        IconButton(icon: Icon(Icons.timer), onPressed: () {
          onTimer();
        }, color: Colors.white),
        Text("Timer",  style: TextStyle(color: Colors.white)),
        IconButton(icon: Icon(isFlashOn?Icons.flash_off:Icons.flash_on), onPressed: () {
          onFLash();
        }, color: Colors.white),
        Text("Flash",  style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
