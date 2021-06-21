part of 'fav_bloc.dart';

abstract class FavEvent extends Equatable {
  const FavEvent();

  @override
  List<Object> get props => [];
}

class LoadFav extends FavEvent {}

class AddFav extends FavEvent {
  final VideoModel video;

  AddFav(this.video);

  @override
  List<Object> get props => [video];
}
