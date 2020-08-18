import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 9:03 PM
///

class VideoLengthPicker extends StatefulWidget {
  @override
  _VideoLengthPickerState createState() => _VideoLengthPickerState();
}

class _VideoLengthPickerState extends State<VideoLengthPicker> {
  int _currentValue = 15;

  @override
  Widget build(BuildContext context) {
    return  NumberPicker.integer(
        scrollDirection: Axis.horizontal,
        initialValue: _currentValue,
        minValue: 15,
        step: 15,
        maxValue: 60,
        onChanged: (newValue) =>
            setState(() => _currentValue = newValue));
  }
}
