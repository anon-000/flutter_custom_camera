import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/19/2020 6:45 AM
///



class OptionsDisplayWidget extends StatefulWidget {
  final List<String> data;
  final Function(int i) onTap;
  final int currentIndex;
  OptionsDisplayWidget({this.data, this.onTap, this.currentIndex=0});

  @override
  _OptionsDisplayWidgetState createState() => _OptionsDisplayWidgetState();
}

class _OptionsDisplayWidgetState extends State<OptionsDisplayWidget> {

  int currentOption = 0;

  @override
  void initState() {
    super.initState();
    currentOption = widget.currentIndex;
  }

  @override
  void didUpdateWidget(OptionsDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(currentOption!= widget.currentIndex){
      setState(() {
        currentOption = widget.currentIndex;
        print("old : " + oldWidget.currentIndex.toString());
        print('noiw :' + widget.currentIndex.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.data.map((e){
        int index = widget.data.indexOf(e);
        return GestureDetector(
          onTap: (){
            currentOption = widget.data.indexOf(e);
            print("tap :" + index.toString());
            widget.onTap(widget.data.indexOf(e));
          },
          child: Container(
            width: 70,
            child: Center(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(e, style: TextStyle(
                  color: currentOption == widget.data.indexOf(e) ? Colors.black:Colors.white,
                  fontSize: 12
              ),),
            )),
            decoration: BoxDecoration(
                color: currentOption == widget.data.indexOf(e) ? Colors.white:Colors.black.withOpacity(0.3)
            ),
          ),
        );
      }).toList(),
    );
  }
}
