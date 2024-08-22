import 'package:camera/camera.dart';
import 'package:get/get.dart';

class InterviewController extends GetxController {
  late CameraController _cameraController;
  late Future<void> cameraValue;

  List<String> questions = [
    'Talk about a time where you demonstrated leadership qualities.',
    'What is you ideal work environment?',
    'Why did you decide to apply for a position at this company?'
  ];
  int currentQuestion = 0;

  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;

  XFile? videoFile;
  bool isDoneRecording = false;

  @override
  void onInit() async {
    super.onInit();
    _cameraController =
        CameraController((await availableCameras())[1], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  void startInterviewQuestion() {
    isRecording = true;
  }

  void endInterviewQuestion() {
    isRecording = false;
    isDoneRecording = true;
  }

  void nextQuestion() {
    currentQuestion++;
  }
}
