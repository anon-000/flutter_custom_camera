import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/19/2020 6:45 AM
///



class OptionsDisplayWidget extends StatelessWidget {
  final List<String> data;
  final Function(int i) onTap;
  final int currentIndex;
  OptionsDisplayWidget({this.data, this.onTap, this.currentIndex=0});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: data.map((e) => GestureDetector(
        onTap: (){
          onTap(data.indexOf(e));
        },
        child: Container(
          width: 70,
          child: Center(child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(e, style: TextStyle(
                color: currentIndex == data.indexOf(e)?Colors.black:Colors.white,
                fontSize: 12
            ),),
          )),
          decoration: BoxDecoration(
              color: currentIndex == data.indexOf(e)?Colors.white:Colors.black.withOpacity(0.3)
          ),
        ),
      )).toList(),
    );
  }
}
