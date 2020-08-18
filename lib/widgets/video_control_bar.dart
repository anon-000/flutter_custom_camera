import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 8:45 PM
///
///

class VideoControlBar extends StatelessWidget {
  final Function onFlip;
  final Function onFLash;
  VideoControlBar({this.onFlip, this.onFLash});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(Icons.switch_camera), onPressed: () {
          onFlip();
        }, color: Colors.white,),
        Text("Flip", style: TextStyle(color: Colors.white),),
        IconButton(icon: Icon(Icons.directions_run), onPressed: () {}, color: Colors.white),
        Text("Speed",  style: TextStyle(color: Colors.white)),
        IconButton(icon: Icon(Icons.brush), onPressed: () {}, color: Colors.white),
        Text("Beauty",  style: TextStyle(color: Colors.white)),
        IconButton(icon: Icon(Icons.timer), onPressed: () {}, color: Colors.white),
        Text("Timer",  style: TextStyle(color: Colors.white)),
        IconButton(icon: Icon(Icons.flash_on), onPressed: () {
          onFLash();
        }, color: Colors.white),
        Text("Flash",  style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
