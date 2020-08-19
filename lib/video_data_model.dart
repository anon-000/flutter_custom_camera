import 'package:flutter_custom_camera/config.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 8/18/2020 8:20 PM
///



class VideoDatum {
  VideoDatum({
    this.path,
    this.beautyLevel,
    this.videoSpeed,
    this.videoLength
  });

  String path ;
  int videoLength;
  VideoSpeed videoSpeed;
  BeautyLevel beautyLevel;

  factory VideoDatum.fromJson(Map<String, dynamic> json) => VideoDatum(
    path: json["total"] ?? '',
    beautyLevel: json["limit"] ?? BeautyLevel.medium,
    videoSpeed: json["skip"] ?? VideoSpeed.normal,
    videoLength: json["videoLength"] ??0
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "beautyLevel": beautyLevel,
    "videoSpeed": videoSpeed,
    "videoLength": videoLength
  };
}
