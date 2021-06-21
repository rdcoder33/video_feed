import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_feed/src/logic/blocs/fav_bloc/fav_bloc.dart';
import 'package:video_feed/src/logic/models/video_model.dart';
 
import 'package:video_feed/src/logic/repositories/storage_repository.dart';
import 'package:video_feed/src/logic/services/storage_service.dart';
import 'package:video_feed/src/ui/Theme/colors.dart';
import 'package:video_feed/src/ui/utils/globals.dart';
 
import 'package:video_feed/src/ui/widgets/Favorite/no_favorite.dart';
import 'package:video_feed/src/ui/widgets/common/loader.dart';
import 'package:video_feed/src/ui/widgets/common/video_list_widget.dart';
 

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavBloc _favBloc =
      FavBloc(StorageRepo(storageService: StorageService('storage')));
  late List<VideoModel> videoData = [];
  int lastMilli = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();
    _favBloc.add(LoadFav());
  }

  @override
  void dispose() {
    _favBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavBloc, FavState>(
      bloc: _favBloc,
      builder: (context, state) {
        if (state is FavNotInitialized) {
          return Loader();
        }
        if (state is FavLoaded) {
          return ListView.builder(
              itemCount: state.videos == null ? 0 : state.videos!.length,
              itemBuilder: (context, index) {
                return Container(
                  color:
                      appTheme == AppTheme.LightTheme ? bgColor : bgColorDark,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      VideoListWidget(videoData: state.videos![index])
                    ],
                  ),
                );
              });
        } else {
          return NoFavWidget();
        }
      },
    );
  }
}
