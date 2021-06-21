import 'package:better_player/better_player.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:video_feed/src/logic/models/video_player_model.dart';
import 'package:video_feed/src/ui/Theme/colors.dart';

class VideoSlides extends StatelessWidget {
  final BetterPlayerController? controller;
  final VideoPlayerModel? videoListData;

  const VideoSlides({Key? key, this.controller, this.videoListData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (videoListData!.videoUrl.length > 1) {
      return Swiper(
        itemCount: videoListData!.videoUrl.length,
        scrollDirection: Axis.horizontal,
        onIndexChanged: (index) {
          controller!.setupDataSource(
              BetterPlayerDataSource.network(videoListData!.videoUrl[index]));

          controller!.play();
        },
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                color: bgColor,
                activeColor: Theme.of(context).accentColor,
                size: 10.0,
                activeSize: 10.0)),
        itemBuilder: (
          BuildContext context,
          int index,
        ) =>
            Container(
          child: BetterPlayer(
            controller: controller!,
          ),
        ),
      );
    } else {
      return BetterPlayer(
        controller: controller!,
      );
    }
  }
}
