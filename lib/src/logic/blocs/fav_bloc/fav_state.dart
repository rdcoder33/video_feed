part of 'fav_bloc.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object> get props => [];
}

class FavNotInitialized extends FavState {}

class FavLoaded extends FavState {
  final List<VideoModel?>? videos;

  FavLoaded(this.videos);

  @override
  List<Object> get props => [videos?? []];
}

class FavAdded extends FavState {}

class FavDeleted extends FavState {
  final int index;

  FavDeleted(this.index);

  @override
  List<Object> get props => [index];
}
