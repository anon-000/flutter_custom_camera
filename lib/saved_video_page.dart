import 'package:flutter/material.dart';
import 'package:flutter_custom_camera/video_data_model.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 8:23 PM
///
///



class SavedVideoPage extends StatelessWidget {
  final List<VideoDatum> videos;
  SavedVideoPage({this.videos=const []});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved video Page"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: videos.map((e)=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('video path :'+e.path),
              Text('video length :'+e.videoLength.toString()),
              Text('video speed :' + e.videoSpeed.toString()),
              Text('video beauty :'+ e.beautyLevel.toString()),
              Divider(thickness: 4,)
            ],
          )).toList(),
        ),
      ),
    );
  }
}
