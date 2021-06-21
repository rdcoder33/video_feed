import 'package:better_player/better_player.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/cupertino.dart';

class ReusableVideoListController {
  final List<BetterPlayerController> _betterPlayerControllerRegistry = [];
  final List<BetterPlayerController> _usedBetterPlayerControllerRegistry = [];

  ReusableVideoListController() {
    for (int index = 0; index < 3; index++) {
      _betterPlayerControllerRegistry.add(
        BetterPlayerController(
          BetterPlayerConfiguration(
              controlsConfiguration: BetterPlayerControlsConfiguration(
                  audioTracksIcon: CupertinoIcons.mic,
                  playIcon: CupertinoIcons.play,
                  pauseIcon: CupertinoIcons.pause,
                  fullscreenEnableIcon: CupertinoIcons.fullscreen,
                  fullscreenDisableIcon: CupertinoIcons.fullscreen_exit,
                  muteIcon: CupertinoIcons.speaker,
                  unMuteIcon: CupertinoIcons.speaker_slash,
                  playbackSpeedIcon: CupertinoIcons.speedometer,
                  subtitlesIcon: CupertinoIcons.t_bubble,
                  enableQualities: false,
                  showControlsOnInitialize: false,
                  skipBackIcon: CupertinoIcons.gobackward_15,
                  skipForwardIcon: CupertinoIcons.goforward_15,
                  overflowMenuIcon: CupertinoIcons.settings),
              handleLifecycle: false,
              autoDispose: false),
        ),
      );
    }
  }

  BetterPlayerController? getBetterPlayerController() {
    final freeController = _betterPlayerControllerRegistry.firstWhereOrNull(
        (controller) =>
            !_usedBetterPlayerControllerRegistry.contains(controller));
    
    if (freeController != null) {
      _usedBetterPlayerControllerRegistry.add(freeController);
    }

    return freeController;
  }

  void freeBetterPlayerController(
      BetterPlayerController? betterPlayerController) {
    _usedBetterPlayerControllerRegistry.remove(betterPlayerController);
  }

  void dispose() {
    _betterPlayerControllerRegistry.forEach((controller) {
      controller.dispose();
    });
  }
}
