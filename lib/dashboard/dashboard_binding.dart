import 'package:get/get.dart';
import '../login_screen/login_controller.dart';
import 'dashboard_controller.dart';
import '../recordings_screen/recordings_controller.dart';
import '../speech_screen/speech_controller.dart';
import '../interview_screen/interview_controller.dart';
import '../profile_screen/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<RecordingsController>(() => RecordingsController());
    Get.lazyPut<SpeechController>(() => SpeechController());
    Get.lazyPut<InterviewController>(() => InterviewController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
