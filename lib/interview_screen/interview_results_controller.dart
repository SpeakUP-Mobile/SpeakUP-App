import 'package:get/get.dart';
import 'interview_recordings.dart';

class InterviewResultsController extends GetxController {
  late String recordingName;
  late String date;
  late String time;
  late String dateTime;
  late int score;
  late List<String> videoPaths;

  @override
  void onInit() {
    recordingName = Get.arguments[0];
    date = Get.arguments[1];
    time = Get.arguments[2];
    dateTime = '$time on $date';
    score = Get.arguments[3];
    videoPaths = Get.arguments[4];
    super.onInit;
  }

  void viewRecordings() {
    Get.to(const InterviewRecordings(), arguments: videoPaths);
  }

  void backToHome() {
    Get.back();
    Get.back();
    Get.back();
  }
}
