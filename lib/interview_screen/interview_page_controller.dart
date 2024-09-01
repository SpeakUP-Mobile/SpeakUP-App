import 'dart:async';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'interview_results.dart';

class InterviewPageController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  RxBool isPreviewLoading = true.obs;

  List<String> questions = [
    'Talk about a time where you demonstrated leadership qualities.',
    'What is you ideal work environment?',
    'Why did you decide to apply for a position at this company?'
  ];
  RxInt currentQuestion = 0.obs;
  int numQuestions = 3;

  RxBool isRecording = false.obs;
  RxBool isDoneRecording = false.obs;

  RxInt recordingSeconds = 0.obs;
  bool endTimer = false;
  RxList<int> questionTimes = <int>[].obs;

  RxBool isCameraFront = true.obs;

  List<String> videoPaths = [];

  @override
  void onInit() async {
    super.onInit();
    currentQuestion.value = 0;
    isPreviewLoading.value = true;
    isCameraFront.value = true;
    questionTimes.value =
        List<int>.filled(questions.length, 0, growable: false);
    cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.high);
    await cameraController.initialize();
    isPreviewLoading.value = false;
  }

  Future<void> pressRecord() async {
    if (!isPreviewLoading.value) {
      if (!isRecording.value && !isDoneRecording.value) {
        isPreviewLoading.value = true;
        await cameraController.startVideoRecording();
        isPreviewLoading.value = false;
        Timer.periodic(const Duration(seconds: 1), (Timer t) => timer(t));
        isRecording.value = true;
      } else if (isRecording.value) {
        final videoPath = (await cameraController.stopVideoRecording()).path;
        videoPaths.insert(currentQuestion.value, videoPath);
        endTimer = true;
      }
    }
  }

  void timer(Timer t) {
    if (endTimer) {
      t.cancel();
      endTimer = false;
      questionTimes[currentQuestion.value] = recordingSeconds.value;
      recordingSeconds.value = 0;
      isRecording.value = false;
      isDoneRecording.value = true;
    } else {
      recordingSeconds.value++;
    }
  }

  void retakeRecording() async {
    await File(videoPaths[currentQuestion.value]).delete();
    videoPaths.removeAt(currentQuestion.value);
    questionTimes[currentQuestion.value] = 0;
    isDoneRecording.value = false;
    Get.back();
  }

  void flipCamera() async {
    if (cameras.length > 1 && !isRecording.value) {
      cameraController = CameraController(
          cameras[isCameraFront.value ? 0 : 1], ResolutionPreset.high);
      isPreviewLoading.value = true;
      await cameraController.initialize();
      isPreviewLoading.value = false;
      isCameraFront.value = !isCameraFront.value;
    }
  }

  void previousQuestion() {
    if (currentQuestion.value != 0) {
      currentQuestion--;
      isDoneRecording.value = true;
    }
  }

  void nextQuestion() {
    if (isDoneRecording.value) {
      if (currentQuestion.value != questions.length - 1) {
        currentQuestion++;
        isDoneRecording.value = videoPaths.length > currentQuestion.value;
      }
    }
  }

  void exitInterview() async {
    for (String path in videoPaths) {
      await File(path).delete();
    }
    Get.back();
    Get.back();
    Get.back();
  }

  void endInterview() {
    Get.to(const InterviewResults(), arguments: videoPaths);
  }
}
