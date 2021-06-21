import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:video_feed/src/logic/models/video_model.dart';

class APIModel extends Equatable {
  final bool? status;
  final int? totalVideos;
  final int? videoCount;
  final List<VideoModel> videosData;
  APIModel({
    required this.status,
    required this.totalVideos,
    required this.videoCount,
    required this.videosData,
  });

  @override
  List<Object> get props => [videosData];

  APIModel copyWith({
    bool? status,
    int? totalVideos,
    int? videoCount,
    List<VideoModel>? videosData,
  }) {
    return APIModel(
      status: status ?? this.status,
      totalVideos: totalVideos ?? this.totalVideos,
      videoCount: videoCount ?? this.videoCount,
      videosData: videosData ?? this.videosData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'totalVideos': totalVideos,
      'videoCount': videoCount,
      'videosData': videosData.map((x) => x.toMap()).toList(),
    };
  }

  factory APIModel.fromMap(Map<String, dynamic> map) {
    return APIModel(
      status: map['status'],
      totalVideos: map['total_videos'],
      videoCount: map['video_count'],
      videosData: List<VideoModel>.from(
          map['data'].map((x) => VideoModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory APIModel.fromJson(String source) =>
      APIModel.fromMap(json.decode(source));

  // @override
  // bool get stringify => true;
}
