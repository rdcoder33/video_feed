import 'dart:convert';

import 'package:equatable/equatable.dart';

class VideoModel extends Equatable {
  final String description;
  final List<String> sources;
  final String subtitle;
  final String thumbnail;
  final String title;
  VideoModel({
    required this.description,
    required this.sources,
    required this.subtitle,
    required this.thumbnail,
    required this.title,
  });


  VideoModel copyWith({
    String? description,
    List<String>? sources,
    String? subtitle,
    String? thumbnail,
    String? title,
  }) {
    return VideoModel(
      description: description ?? this.description,
      sources: sources ?? this.sources,
      subtitle: subtitle ?? this.subtitle,
      thumbnail: thumbnail ?? this.thumbnail,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'sources': sources,
      'subtitle': subtitle,
      'thumbnail': thumbnail,
      'title': title,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      description: map['description'],
      sources: List<String>.from(map['sources']),
      subtitle: map['subtitle'],
      thumbnail: map['thumb']?? '',
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      description,
      sources,
      
    ];
  }
}
