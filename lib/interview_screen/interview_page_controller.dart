import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'interview_results.dart';

class InterviewPageController extends GetxController {
  late CameraController cameraController;
  RxBool isCameraInitialized = false.obs;
  late Future<void> cameraValue;

  List<String> questions = [
    'Talk about a time where you demonstrated leadership qualities.',
    'What is you ideal work environment?',
    'Why did you decide to apply for a position at this company?'
  ];
  RxInt currentQuestion = 0.obs;
  int numQuestions = 3;

  RxBool isRecording = false.obs;
  bool flash = false;
  bool isCameraFront = true;

  List<String> videoPaths = [];
  RxBool isDoneRecording = false.obs;

  @override
  void onInit() async {
    super.onInit();
    currentQuestion.value = 0;
    isCameraInitialized.value = false;
    List<CameraDescription> cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.high);
    cameraValue = cameraController.initialize();
    await cameraValue;
    isCameraInitialized.value = true;
  }

  Future<void> pressRecord() async {
    if (isCameraInitialized.value) {
      if (!isRecording.value && !isDoneRecording.value) {
        await cameraController.startVideoRecording();
        isRecording.value = true;
      } else if (isRecording.value) {
        final videoPath = (await cameraController.stopVideoRecording()).path;
        videoPaths.add(videoPath);
        isRecording.value = false;
        isDoneRecording.value = true;
      } else {
        await File(videoPaths[currentQuestion.value]).delete();
        videoPaths.removeAt(currentQuestion.value);
      }
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
        isDoneRecording.value = false;
      } else {
        Get.to(const InterviewResults(), arguments: videoPaths);
      }
    }
  }

  void exitInterview() {
    Get.back();
    Get.back();
    Get.back();
  }

  void endInterview() {
    Get.to(const InterviewResults(), arguments: videoPaths);
  }
}
