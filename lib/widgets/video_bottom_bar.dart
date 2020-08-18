import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 9:11 PM
///



class VideoBottomBar extends StatelessWidget {
  final bool isRecording;
  final Function isRecordClicked;
  VideoBottomBar({this.isRecording=false, this.isRecordClicked});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.image), onPressed: (){}, color: Colors.white,),
        IconButton(icon: Icon(Icons.grid_on), onPressed: (){}, color: Colors.white,),
        IconButton(icon: Icon(isRecording?Icons.stop:Icons.play_circle_filled),
          onPressed: (){
          isRecordClicked();
        },color: Colors.white, iconSize: 80,),
        IconButton(icon: Icon(Icons.delete), onPressed: (){}, color: Colors.white),
        IconButton(icon: Icon(Icons.check_circle, color: Colors.green,), onPressed: (){})
      ],
    );
  }
}
