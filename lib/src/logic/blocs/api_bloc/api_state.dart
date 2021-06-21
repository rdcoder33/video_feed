part of 'api_bloc.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiNotLoaded extends ApiState {}

class ApiLoaded extends ApiState {
  final List<VideoModel> videos;
  final bool hasReachedMax;
  ApiLoaded({
    required this.videos,
    required this.hasReachedMax,
  });

  ApiLoaded copyWith({
    List<VideoModel>? videos,
    bool? hasReachedMax,
  }) {
    return ApiLoaded(
      videos: videos ?? this.videos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [videos, hasReachedMax];

  @override
  String toString() =>
      'Videos Loaded { posts: ${videos.length}, hasReachedMax: $hasReachedMax }';
}

class ApiFailedToLoad extends ApiState {}
