import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:video_feed/src/logic/models/video_player_model.dart';
import 'package:video_feed/src/ui/utils/reusable_video_controller.dart';
import 'package:video_feed/src/ui/widgets/video/video_carasuol.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReusableVideoListWidget extends StatefulWidget {
  final VideoPlayerModel videoListData;
  final ReusableVideoListController videoListController;
  final Function? canBuildVideo;

  const ReusableVideoListWidget({
    Key? key,
    required this.videoListData,
    required this.videoListController,
    this.canBuildVideo,
  }) : super(key: key);

  @override
  _ReusableVideoListWidgetState createState() =>
      _ReusableVideoListWidgetState();
}

class _ReusableVideoListWidgetState extends State<ReusableVideoListWidget> {
  VideoPlayerModel? get videoListData => widget.videoListData;
  BetterPlayerController? controller;
  StreamController<BetterPlayerController?>
      betterPlayerControllerStreamController = StreamController.broadcast();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerControllerStreamController.close();

    super.dispose();
  }

  void _setupController() {
    if (controller == null) {
      
      controller = widget.videoListController.getBetterPlayerController();
      if (controller != null) {
        controller!.setupDataSource(BetterPlayerDataSource.network(
            videoListData!.videoUrl.first,
            cacheConfiguration:
                BetterPlayerCacheConfiguration(useCache: false)));
        if (!betterPlayerControllerStreamController.isClosed) {
          betterPlayerControllerStreamController.add(controller);
        }

        controller!.addEventsListener(onPlayerEvent);
        _initialized = true;
      }
    }
  }

  void _freeController() {
    if (!_initialized) {
      _initialized = true;

      widget.videoListController.freeBetterPlayerController(controller);
      return;
    }
    if (controller != null && _initialized) {
      controller!.removeEventsListener(onPlayerEvent);
      widget.videoListController.freeBetterPlayerController(controller);
      controller!.pause();
      controller!.dispose();
      controller = null;
      if (!betterPlayerControllerStreamController.isClosed) {
        betterPlayerControllerStreamController.add(null);
      }

      _initialized = false;
    }
  }

  void onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      videoListData!.lastPosition = event.parameters!["progress"] as Duration?;
    }
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (videoListData!.lastPosition != null) {
        controller!.seekTo(videoListData!.lastPosition!);
      }
      if (videoListData!.wasPlaying!) {
        controller!.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalObjectKey key =
        GlobalObjectKey(hashCode.toString() + DateTime.now().toString());
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibilityDetector(
            key: key,
            onVisibilityChanged: (info) {
              // if (!widget.canBuildVideo!()) {
              //   _timer?.cancel();
              //   _timer = null;
              //   _timer = Timer(Duration(milliseconds: 500), () {
              //     if (info.visibleFraction >= 1) {
              //       // ! when 2 videos have visible fraction >= 1, in development
              //       // if (key.currentContext != null) {
              //       //   RenderBox? box =
              //       //       key.currentContext!.findRenderObject() as RenderBox?;
              //       //   Offset position = box!.localToGlobal(Offset.zero);
              //       //   currentVideoPosition = position.dy;

              //       //   if (position.dy <
              //       //       MediaQuery.of(context).size.height / 2) {
              //       //     _setupController();
              //       //   } else {
              //       //     _freeController();
              //       //   }
              //       // } else {
              //       //   _freeController();
              //       // }
              //     } else {
              //       _freeController();
              //     }
              //   });
              //   return;
              // }
              if (info.visibleFraction >= 1) {
                _setupController();
                if (_initialized) {
                  controller!.play();
                }
              } else {
                _freeController();
              }

              // if (key.currentContext != null) {
              //   RenderBox? box =
              //       key.currentContext!.findRenderObject() as RenderBox?;
              //   Offset position = box!.localToGlobal(Offset.zero);
              //   if (position.dy < MediaQuery.of(context).size.height / 2) {
              //     if (info.visibleFraction >= 1) {
              //       _setupController();
              //     } else {
              //       _freeController();
              //     }
              //     // auto play handler
              //     if (controller != null) {
              //       if (info.visibleFraction >= 1) {
              //         controller!.play();
              //       } else {
              //         controller!.dispose();
              //       }
              //     }
              // print('******************************************');
              // print(position.dx);
              // print(position.dy);
              // print(MediaQuery.of(context).size.height / 2);
              //   }
              // } else {
              //   _freeController();
              // }
            },
            child: StreamBuilder<BetterPlayerController?>(
              stream: betterPlayerControllerStreamController.stream,
              builder: (context, snapshot) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: controller != null
                      ? VideoSlides(
                          controller: controller,
                          videoListData: widget.videoListData,
                        )
                      : Container(
                          color: Colors.grey ,
                          child: Center(
                              child: Icon(
                            CupertinoIcons.play_rectangle,
                            size: 100,
                          )),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    if (controller != null) {
      videoListData!.wasPlaying = controller!.isPlaying();
    }
    _initialized = true;
    super.deactivate();
  }
}
