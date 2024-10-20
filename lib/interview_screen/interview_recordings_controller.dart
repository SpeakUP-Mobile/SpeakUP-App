import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class InterviewRecordingsController extends GetxController {
  late List<String> videoPaths;
  late List<String> questions;
  RxInt currentQuestion = 1.obs;
  RxBool isPlaying = false.obs;
  late Rx<VideoPlayerController> videoController;
  late bool videoEnded;
  Timer? timer;

  @override
  void onInit() async {
    intializeVariables();
    videoController = VideoPlayerController.file(File(videoPaths[0])).obs;
    await resetVideoController();
    timer = Timer.periodic(const Duration(milliseconds: 500),
        (Timer t) => videoController.refresh());
    super.onInit();
  }

  void intializeVariables() {
    videoPaths = Get.arguments[0];
    questions = Get.arguments[1];
    currentQuestion.value = 1;
    isPlaying.value = false;
    videoEnded = false;
  }

  /*
      for (int i = 0; i < videoPaths.length; i++) {
      videoPaths[i] = "${await getFullVideoDir()}${videoPaths[i]}";
    }
  */

  @override
  void onClose() {
    videoController.value.dispose();
    super.onClose();
  }

  Future<String?> getFullVideoDir() async {
    Directory path = await getApplicationDocumentsDirectory();
    return '${path.path}/camera/videos/';
  }

  void videoEnd() async {
    if (videoController.value.value.position ==
        videoController.value.value.duration) {
      videoController.value.pause();
      videoEnded = true;
      isPlaying.value = false;
    }
  }

  void playVideo() async {
    if (videoEnded) {
      replayVideo();
    } else {
      await videoController.value.play();
      isPlaying.value = true;
    }
  }

  void pauseVideo() async {
    await videoController.value.pause();
    isPlaying.value = false;
  }

  void replayVideo() async {
    await videoController.value.seekTo(const Duration());
    await videoController.value.play();
    isPlaying.value = true;
    videoEnded = false;
  }

  void previousQuestion() async {
    if (currentQuestion.value > 1) {
      currentQuestion.value--;
    }
    await resetVideoController();
  }

  void nextQuestion() async {
    if (currentQuestion.value < questions.length) {
      currentQuestion.value++;
    }
    await resetVideoController();
  }

  Future<void> resetVideoController() async {
    videoController.value.dispose();
    videoController.value =
        VideoPlayerController.file(File(videoPaths[currentQuestion.value - 1]));
    await videoController.value.initialize();
    videoController.value.addListener(() => videoEnd());
    videoController.refresh();
    await videoController.value.play();
    isPlaying.value = true;
  }
}
