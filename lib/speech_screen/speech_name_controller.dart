import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'speech_analysis.dart';

class SpeechNameController extends GetxController {
  String name = '';
  var validName = true.obs;

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
    validName = isValidName.obs;
    print('function name: $name');
    print('class name: ${this.name}');
    print('validName: ${validName.isTrue}');
  }

  Future<bool> get isRepeatName async {
    final path = await _localPath;

    return await File('$path/$name.metadata').exists();
  }

  analyze(String videoPath) async {
    if (validName.isTrue && name != '') {
      await createMetadata(videoPath);
      Get.to(SpeechAnalysisPage(fileName: name));
    }
  }

  cancel() {
    Get.back();
  }
}
