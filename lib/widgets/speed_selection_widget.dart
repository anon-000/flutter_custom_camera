import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 8:51 PM
///




class SpeedSelectionWidget extends StatefulWidget {
  @override
  _SpeedSelectionWidgetState createState() => _SpeedSelectionWidgetState();
}

class _SpeedSelectionWidgetState extends State<SpeedSelectionWidget> {
  int _currentValue = 15;

  @override
  Widget build(BuildContext context) {
    return  NumberPicker.integer(
      scrollDirection: Axis.horizontal,
        initialValue: _currentValue,
        minValue: 0,
        maxValue: 100,
        onChanged: (newValue) =>
            setState(() => _currentValue = newValue));
  }
}
