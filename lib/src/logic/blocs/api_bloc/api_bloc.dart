import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_feed/src/logic/models/api_model.dart';

import 'package:video_feed/src/logic/models/video_model.dart';
import 'package:video_feed/src/logic/repositories/api_repository.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  APIRepository apiRepository;

  ApiBloc(
    this.apiRepository,
  ) : super(ApiNotLoaded());

  // @override
  // Stream<Transition<ApiEvent, ApiState>> transformEvents(
  //   Stream<ApiEvent> events,
  //   TransitionFunction<ApiEvent, ApiState> transitionFn,
  // ) {
  //   return super.transformEvents(

  //     events.debounceTime(const Duration(milliseconds: 500)),
  //     transitionFn,
  //   );
  // }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    super.onError(error, stackTrace);
  }

  @override
  Stream<ApiState> mapEventToState(
    ApiEvent event,
  ) async* {
    if (event is LoadApi) {
      yield* _mapLoadApiToState(state);
    } else if (event is FailToLoadApi) {
      yield* _mapFailToLoadApiToState();
    }
  }

  Stream<ApiState> _mapLoadApiToState(ApiState state) async* {
   
    if (!_hasReachedMax(state)) {
      if (state is ApiNotLoaded) {
        Map<String, dynamic> data =
            await apiRepository.getVideos(length: 5, offset: 0);
 
       
        yield ApiLoaded(
            videos: APIModel.fromMap(data).videosData, hasReachedMax: false);
      }
      if (state is ApiLoaded) {
        Map<String, dynamic> data = await apiRepository.getVideos(
            length: 5, offset: state.videos.length);
        List<VideoModel> videos = APIModel.fromMap(data).videosData;
        
        yield videos.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : ApiLoaded(
                videos: List.of(state.videos)..addAll(videos),
                hasReachedMax: false);
      }
    }
  }

  Stream<ApiState> _mapFailToLoadApiToState() async* {
    // handle error here
  }
}

// helper function
bool _hasReachedMax(ApiState state) =>
    state is ApiLoaded && state.hasReachedMax;
