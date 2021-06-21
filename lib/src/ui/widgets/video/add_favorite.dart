import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_feed/src/logic/blocs/fav_bloc/fav_bloc.dart';
import 'package:video_feed/src/logic/models/video_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFavBtn extends StatelessWidget {
  final VideoModel videoData;
  const AddFavBtn({Key? key, required this.videoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavBloc, FavState>(
      builder: (context, state) {
        if (state is FavLoaded && state.videos != null) {
          return Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 4,
                15, MediaQuery.of(context).size.width / 4, 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: state.videos!.contains(videoData)
                        ? Theme.of(context).accentColor
                        : Theme.of(context).primaryColor),
                onPressed: state.videos!.contains(videoData)
                    ? () {
                        
                      }
                    : () {
                        
                        FavBloc favBloc = BlocProvider.of<FavBloc>(context);
                        favBloc.add(AddFav(videoData));
                        favBloc.add(LoadFav());
                      },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(CupertinoIcons.star_fill),
                    state.videos!.contains(videoData)
                        ? Text('Favorite')
                        : Text('Add Favorites'),
                  ],
                )),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
