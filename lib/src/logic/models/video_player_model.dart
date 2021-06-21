import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class VideoPlayerModel extends Equatable {
  final String thumbnail;
  final String videoTitle;
  final List<String> videoUrl;
  Duration? lastPosition;
  bool? wasPlaying = false;
  VideoPlayerModel({
    required this.thumbnail,
    required this.videoTitle,
    required this.videoUrl,
    this.lastPosition,
    this.wasPlaying,
  });

  Map<String, dynamic> toMap() {
    return {
      'thumbnail': thumbnail,
      'videoTitle': videoTitle,
      'videoUrl': videoUrl,
      'lastPosition': lastPosition!.inSeconds,
      'wasPlaying': wasPlaying,
    };
  }

  factory VideoPlayerModel.fromMap(Map<String, dynamic> map) {
    return VideoPlayerModel(
      thumbnail: map['thumbnail'],
      videoTitle: map['videoTitle'],
      videoUrl: List<String>.from(map['videoUrl']),
      lastPosition: Duration(seconds: map['lastPosition']),
      wasPlaying: map['wasPlaying'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoPlayerModel.fromJson(String source) =>
      VideoPlayerModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      thumbnail,
      videoTitle,
      videoUrl,
    ];
  }

  VideoPlayerModel copyWith({
    String? thumbnail,
    String? videoTitle,
    List<String>? videoUrl,
    Duration? lastPosition,
    bool? wasPlaying,
  }) {
    return VideoPlayerModel(
      thumbnail: thumbnail ?? this.thumbnail,
      videoTitle: videoTitle ?? this.videoTitle,
      videoUrl: videoUrl ?? this.videoUrl,
      lastPosition: lastPosition ?? this.lastPosition,
      wasPlaying: wasPlaying ?? this.wasPlaying,
    );
  }
}
