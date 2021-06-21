import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_feed/src/logic/models/video_model.dart';
import 'package:video_feed/src/logic/models/video_player_model.dart';
import 'package:video_feed/src/ui/utils/reusable_video_controller.dart';
import 'package:video_feed/src/ui/widgets/video/add_favorite.dart';
import 'package:video_feed/src/ui/widgets/video/reusable_video_widget.dart';

class VideoListWidget extends StatelessWidget {
  final VideoModel? videoData;

  const VideoListWidget({Key? key, required this.videoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              children: [
                // NotificationListener<ScrollNotification>(
                //   onNotification: (notification) {
                //     final now = DateTime.now();
                //     final timeDiff = now.millisecondsSinceEpoch - lastMilli;
                //     if (notification is ScrollUpdateNotification) {
                //       final pixelsPerMilli = notification.scrollDelta! / timeDiff;
                //       if (pixelsPerMilli.abs() > 1) {
                //         _canBuildVideo = false;
                //       } else {
                //         _canBuildVideo = true;
                //       }
                //       lastMilli = DateTime.now().millisecondsSinceEpoch;
                //     }

                //     if (notification is ScrollEndNotification) {
                //       _canBuildVideo = true;
                //       lastMilli = DateTime.now().millisecondsSinceEpoch;
                //     }

                //     return true;
                //   },
                ReusableVideoListWidget(
                  canBuildVideo: () => false,
                  videoListData: VideoPlayerModel(
                      thumbnail: '',
                      videoTitle: videoData!.title,
                      videoUrl: videoData!.sources,
                      lastPosition: Duration(seconds: 0),
                      wasPlaying: false),
                  videoListController: ReusableVideoListController(),
                ),

                Container(
                  height: MediaQuery.of(context).size.height / 8,
                  child: Center(
                    child: ListTile(
                      title: Text(
                        videoData!.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          videoData!.subtitle,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    videoData!.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                AddFavBtn(videoData: videoData!),
              ],
            ),
          ),
          // ) // NotificationListener
        ));
  }
}
