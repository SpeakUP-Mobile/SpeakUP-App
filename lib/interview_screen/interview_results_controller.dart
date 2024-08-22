import 'package:get/get.dart';
import 'interview_analysis.dart';

class InterviewResultsController extends GetxController {
  void viewSourceRecordings() {
    List<String> videoPaths = Get.arguments;
    Get.to(const InterviewAnalysis(), arguments: videoPaths);
  }

  void backToHome() {
    Get.back();
    Get.back();
    Get.back();
  }
}
