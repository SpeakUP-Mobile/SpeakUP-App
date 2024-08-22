import 'dart:io';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class InterviewAnalysisController extends GetxController {
  late List<String> videoPaths;
  late VideoPlayerController videoPlayerController;
  bool isVideoPlaying = false;

  @override
  void onInit() {
    super.onInit();
    videoPaths = Get.arguments;
    videoPlayerController = VideoPlayerController.file(File(videoPaths[0]));
    videoPlayerController.initialize();
    videoPlayerController.play();
    isVideoPlaying = true;
    videoPlayerController.setVolume(2);
  }
}
