import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'interview_results.dart';

class InterviewPageController extends GetxController {
  late CameraController cameraController;
  late Future<void> cameraValue;
  RxBool isCameraInitialized = false.obs;

  List<String> questions = [
    'Talk about a time where you demonstrated leadership qualities.',
    'What is you ideal work environment?',
    'Why did you decide to apply for a position at this company?'
  ];
  RxInt currentQuestion = 0.obs;
  int numQuestions = 3;

  RxBool isRecording = false.obs;
  RxBool isDoneRecording = false.obs;

  Rx<Stopwatch> recordingTimer = Stopwatch().obs;
  late List<int> questionTimes;

  bool flash = false;
  bool isCameraFront = true;

  List<String> videoPaths = [];

  @override
  void onInit() async {
    super.onInit();
    currentQuestion.value = 0;
    isCameraInitialized.value = false;
    questionTimes = List<int>.filled(questions.length, 0, growable: false);
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
        recordingTimer.value.start();
        isRecording.value = true;
      } else if (isRecording.value) {
        final videoPath = (await cameraController.stopVideoRecording()).path;
        recordingTimer.value.stop();
        videoPaths.insert(currentQuestion.value, videoPath);
        isRecording.value = false;
        isDoneRecording.value = true;
      }
    }
  }

  void retakeRecording() async {
    await File(videoPaths[currentQuestion.value]).delete();
    videoPaths.removeAt(currentQuestion.value);
    isDoneRecording.value = false;
    Get.back();
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
