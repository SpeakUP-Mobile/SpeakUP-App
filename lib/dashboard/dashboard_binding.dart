import 'package:get/get.dart';
import 'dashboard_controller.dart';
import '../recordings_screen/recordings_controller.dart';
import '../speech_screen/speech_controller.dart';
import '../speech_screen/speech_name_controller.dart';
import '../speech_screen/speech_analysis_controller.dart';
import '../interview_screen/interview_controller.dart';
import '../profile_screen/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<RecordingsController>(() => RecordingsController());
    Get.lazyPut<SpeechController>(() => SpeechController());
    Get.lazyPut<SpeechNameController>(() => SpeechNameController());
    Get.lazyPut<SpeechAnalysisController>(() => SpeechAnalysisController());
    Get.lazyPut<InterviewController>(() => InterviewController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
