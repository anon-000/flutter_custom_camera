import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 9:11 PM
///



class VideoBottomBar extends StatelessWidget {
  final bool isRecording;
  final Function isRecordClicked;
  final Function onNext;
  VideoBottomBar({this.isRecording=false, this.isRecordClicked, this.onNext});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.image), onPressed: (){}, color: Colors.white,),
        IconButton(icon: Icon(Icons.grid_on), onPressed: (){}, color: Colors.white,),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle
          ),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon: Icon(isRecording?Icons.stop:Icons.fiber_manual_record),
            onPressed: (){
            isRecordClicked();
          },color:isRecording? Colors.white: Colors.green, iconSize: 80,),
        ),
        IconButton(icon: Icon(Icons.delete), onPressed: (){}, color: Colors.white),
        IconButton(icon: Icon(Icons.check_circle, color: Colors.green,), onPressed: (){
          onNext();
        })
      ],
    );
  }
}
