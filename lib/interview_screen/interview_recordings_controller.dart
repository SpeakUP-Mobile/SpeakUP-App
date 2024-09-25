import 'package:get/get.dart';

class InterviewRecordingsController extends GetxController {
  late List<String> videoPaths;
  late List<String> questions;
  RxInt currentQuestion = 1.obs;
  RxBool isPreviewLoading = false.obs;
  RxBool isPlaying = false.obs;

  @override
  void onInit() {
    videoPaths = Get.arguments[0];
    questions = Get.arguments[1];
    currentQuestion.value = 1;
    isPreviewLoading.value = false;
    isPlaying.value = false;
    super.onInit();
  }
}
