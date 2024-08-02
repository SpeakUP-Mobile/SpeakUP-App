import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../recordings_screen/recordings_controller.dart';
import 'speech_analysis.dart';
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

  String name = '';
  RxBool validName = true.obs;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future createMetadata(String videoPath) async {
    final path = await _localPath;
    final file = File('$path/$name.metadata');
    await file.writeAsString('$name\n', mode: FileMode.append); //Speech name
    await file.writeAsString('$videoPath\n',
        mode: FileMode.append); //Path of actual video
    await file.writeAsString('interview\n',
        mode: FileMode.append); //Interview or Speech
    await file.writeAsString('4\n', mode: FileMode.append); //Rating
  }

  updateName(name) async {
    this.name = name;
    bool isValidName = !await isRepeatName;
    validName.value = isValidName;
  }

  Future<bool> get isRepeatName async {
    final path = await _localPath;

    return name == '' || await File('$path/$name.metadata').exists();
  }

  analyze(String videoPath) async {
    if (validName.isTrue && name != '') {
      await createMetadata(videoPath);
      Get.find<RecordingsController>().updateRecordings();
      Get.to(SpeechAnalysisPage(fileName: name));
    }
  }

  cancel(String videoPath) async {
    await File(videoPath).delete();
    Get.back();
  }
}
