import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:video_feed/src/logic/blocs/api_bloc/api_bloc.dart';
import 'package:video_feed/src/logic/blocs/fav_bloc/fav_bloc.dart';
import 'package:video_feed/src/logic/models/video_model.dart';
import 'package:video_feed/src/logic/models/video_player_model.dart';
import 'package:video_feed/src/logic/repositories/api_repository.dart';
import 'package:video_feed/src/logic/services/api_service.dart';
import 'package:video_feed/src/ui/Theme/colors.dart';
import 'package:video_feed/src/ui/utils/custom_scroll_physics.dart';
import 'package:video_feed/src/ui/utils/globals.dart';
import 'package:video_feed/src/ui/utils/reusable_video_controller.dart';
import 'package:video_feed/src/ui/widgets/common/loader.dart';
import 'package:video_feed/src/ui/widgets/common/video_list_widget.dart';
import 'package:video_feed/src/ui/widgets/video/add_favorite.dart';
import 'package:video_feed/src/ui/widgets/video/reusable_video_widget.dart';
import 'package:video_player/video_player.dart';

class VideoFeed extends StatefulWidget {
  VideoFeed({Key? key}) : super(key: key);

  @override
  _VideoFeedState createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  final _scrollController = ScrollController();
  final ApiBloc _apiBloc = ApiBloc(APIRepository(APIService()));
  late List<VideoModel> videoData = [];
  int lastMilli = DateTime.now().millisecondsSinceEpoch;
  bool _canBuildVideo = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _apiBloc.add(LoadApi());
  }

  @override
  void dispose() {
    _apiBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _apiBloc.add(LoadApi());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      bloc: _apiBloc,
      listener: (context, state) {
        if (state is ApiLoaded && !state.hasReachedMax) {
          videoData = state.videos;
        }
      },
      builder: (context, state) {
        FavBloc favBloc = context.watch<FavBloc>();
        if (state is ApiNotLoaded && favBloc.state is FavLoaded) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ApiFailedToLoad) {
          return Center(
            child: Text('Something went Wrong!'),
          );
        }
        if (state is ApiLoaded) {
          if (state.videos.isEmpty) {
            return Center(
              child: Text('No Video'),
            );
          }

          return ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.videos.length
                  : state.videos.length + 1,
              itemBuilder: (context, index) {
                return index >= videoData.length
                    ?  Loader()
                    : Container(
                        color: appTheme == AppTheme.LightTheme
                            ? bgColor
                            : bgColorDark,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            VideoListWidget(videoData: state.videos[index])
                          ],
                        ),
                      );
              });
        }
        return Loader();
      },
    );
  }
}
