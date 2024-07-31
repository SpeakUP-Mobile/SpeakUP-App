import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'speech_name.dart';

class SpeechController extends GetxController {
  void getVideoFile(ImageSource source) async {
    final videoFile = await ImagePicker().pickVideo(source: source);

    if (videoFile != null) {
      Get.to(SpeechNamePage(
        videoPath: videoFile.path,
      ));
    }
  }
}
