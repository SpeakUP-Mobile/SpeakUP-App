import 'package:get/get.dart';
import 'package:speakup/explore_screen/explore_controller.dart';
import '../interview_screen/interview_recordings_controller.dart';
import '../interview_screen/interview_results_controller.dart';
import 'dashboard_controller.dart';
import '../recordings_screen/recordings_controller.dart';
import '../interview_screen/interview_page_controller.dart';
import '../profile_screen/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<RecordingsController>(() => RecordingsController());
    Get.lazyPut<InterviewPageController>(() => InterviewPageController());
    Get.lazyPut<InterviewResultsController>(() => InterviewResultsController());
    Get.lazyPut<InterviewRecordingsController>(
        () => InterviewRecordingsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<ExploreController>(() => ExploreController());
  }
}
