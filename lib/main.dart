import 'package:flutter/material.dart';
import 'package:flutter_custom_camera/home_page.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Custom Camera App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
