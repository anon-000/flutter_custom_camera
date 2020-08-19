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
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.3)
          ),
          child: IconButton(icon: Icon(Icons.switch_camera), onPressed: () {
            onFlip();
          }, color: Colors.white,),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: Text("Flip", style: TextStyle(color: Colors.white, fontSize: 12),),
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3)
          ),
          child: IconButton(icon: Icon(Icons.directions_run), onPressed: () {
            onSpeed();
          }, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: Text("Speed",  style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3)
          ),
          child: IconButton(icon: Icon(Icons.brush), onPressed: () {
            onBeauty();
          }, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: Text("Beauty",  style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3)
          ),
          child: IconButton(icon: Icon(Icons.timer), onPressed: () {
            onTimer();
          }, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: Text("Timer",  style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3)
          ),
          child: IconButton(icon: Icon(isFlashOn?Icons.flash_off:Icons.flash_on), onPressed: () {
            onFLash();
          }, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: Text("Flash",  style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ],
    );
  }
}
