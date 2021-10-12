import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/19/2020 9:12 AM
///

class CustomProgressIndicator extends StatelessWidget {
  final double height;
  final Color backgroundColor;
  final Color valueColor;
  final double valueInPercent;
  final double width;
  final int max;
  final List<int> partitions;

  CustomProgressIndicator(
      {this.height = 0,
      this.backgroundColor = Colors.grey,
      this.valueColor = Colors.blue,
      required this.valueInPercent,
      this.width = 100,
      this.partitions = const [],
      this.max = 0});

  @override
  Widget build(BuildContext context) {
    double defaultWidth = Get.width / 1.2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: height ?? 5,
              width: width ?? defaultWidth,
              decoration: BoxDecoration(color: backgroundColor ?? Colors.grey),
            ),
            Row(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: height ?? 5,
                  width: width == null
                      ? (valueInPercent / 100) * defaultWidth
                      : (valueInPercent / 100) * width,
                  decoration:
                      BoxDecoration(color: backgroundColor ?? Colors.green),
                ),
                Transform.scale(
                  scale: 1.6,
                  child: Container(
                    height: 5,
                    width: 3,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                )
              ],
            ),
            Container(
              height: height ?? 5,
              width: width ?? defaultWidth,
              child: Stack(
                children: partitions
                    .map((e) => Positioned(
                          left: width == null
                              ? ((e / max * 100) / 100) * defaultWidth
                              : ((e / max * 100) / 100) * width,
                          child: Transform.scale(
                            scale: 1.6,
                            child: Container(
                              height: 5,
                              width: 3,
                              decoration: BoxDecoration(color: Colors.white),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ],
    );
  }
}
