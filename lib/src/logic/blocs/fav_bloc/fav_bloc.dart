import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:video_feed/src/logic/models/video_model.dart';
import 'package:video_feed/src/logic/repositories/storage_repository.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  StorageRepo storageRepo;

  FavBloc(
    this.storageRepo,
  ) : super(FavNotInitialized());

  @override
  Stream<FavState> mapEventToState(
    FavEvent event,
  ) async* {
    if (event is LoadFav) {
      yield* _mapLoadFavToState();
    } else if (event is AddFav) {
      yield* _mapAddFavToState(event);
    }
  }

  Stream<FavState> _mapLoadFavToState() async* {
    List<VideoModel?>? videos = await storageRepo.getFav();

    yield FavLoaded(videos ?? []);
  }

  Stream<FavState> _mapAddFavToState(AddFav event) async* {
    await storageRepo.addFav(event.video);
    yield FavAdded();
  }
}
