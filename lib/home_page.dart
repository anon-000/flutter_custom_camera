import 'package:flutter/material.dart';
import 'package:flutter_custom_camera/camera_page.dart';
import 'package:get/get.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 8:21 PM
///

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Camera App"),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.teal,
          onPressed: () {
            Get.to(CameraPage());
          },
          child: Text("Open Camera"),
        ),
      ),
    );
  }
}
