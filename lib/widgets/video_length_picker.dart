import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 9:03 PM
///

class VideoLengthPicker extends StatefulWidget {
  final Function(int i)? onChanged;

  VideoLengthPicker({this.onChanged});

  @override
  _VideoLengthPickerState createState() => _VideoLengthPickerState();
}

class _VideoLengthPickerState extends State<VideoLengthPicker> {
  final FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController(initialItem: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ListWheelScrollViewX(
        scrollDirection: Axis.horizontal,
        builder: (c, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              ((index * 15 + 15)).toString() + ' Sec',
              style: index == currentIndex
                  ? TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)
                  : TextStyle(color: Colors.grey.withOpacity(0.6)),
            ),
          );
        },
        itemExtent: 100,
        itemCount: 4,
        controller: fixedExtentScrollController,
        onSelectedItemChanged: (index) {
          print(index.toString());
          setState(() {
            currentIndex = index;
            widget.onChanged!.call(index);
          });
        },
      ),
    );
  }
}

class ListWheelScrollViewX extends StatelessWidget {
  final Widget Function(BuildContext, int) builder;
  final Axis scrollDirection;
  final FixedExtentScrollController? controller;
  final double itemExtent;
  final double diameterRatio;
  final int itemCount;
  final void Function(int)? onSelectedItemChanged;

  const ListWheelScrollViewX(
      {Key? key,
      required this.builder,
      required this.itemExtent,
      this.controller,
      this.onSelectedItemChanged,
      this.scrollDirection = Axis.vertical,
      this.diameterRatio = 100000,
      this.itemCount = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: scrollDirection == Axis.horizontal ? 3 : 0,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: onSelectedItemChanged,
        controller: controller,
        itemExtent: itemExtent,
        diameterRatio: diameterRatio,
        physics: FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (context, index) {
            return RotatedBox(
              quarterTurns: scrollDirection == Axis.horizontal ? 1 : 0,
              child: builder(context, index),
            );
          },
        ),
      ),
    );
  }
}
