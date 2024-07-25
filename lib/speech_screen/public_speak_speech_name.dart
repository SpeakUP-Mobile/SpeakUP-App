import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:public_speak_cac_2024/speech_screen/public_speak_speech_analysis.dart';

class PublicSpeakSpeechName extends StatefulWidget {
  final String filePath;

  const PublicSpeakSpeechName({super.key, required this.filePath});

  @override
  State<PublicSpeakSpeechName> createState() => _PublicSpeakSpeechNameState();
}

class _PublicSpeakSpeechNameState extends State<PublicSpeakSpeechName> {
  String newName = 'Untitled';
  bool validName = true;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$newName.metadata');
  }

  Future<File> createMetadata() async {
    final file = await _localFile;

    // Write the file
    file.writeAsString('videoPath: ${widget.filePath} \n',
        mode: FileMode.append);
    file.writeAsString('videoName: $newName \n', mode: FileMode.append);
    file.writeAsString('isInterview: true \n', mode: FileMode.append);
    return file;
  }

  Future<List<String>> get _fileContents async {
    final file = await _localFile;

    return file.readAsLines();
  }

  checkNameRepitition() async {
    final path = await _localPath;

    if (File('$path/$newName.metadata').existsSync()) {
      validName = false;
      return true;
    } else {
      validName = true;
      return false;
    }
  }

  analyzeSpeech() async {
    final path = await _localPath;
    final fileContents = await _fileContents;
    Get.to(PublicSpeakSpeechAnalysis(
        metadata: File('$path/$newName.metadata'), fileName: fileContents[3]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name this recording',
                  hintText: 'Untitled 1'),
              onChanged: (name) {
                setState(() => newName = name);
              },
              validator: (name) =>
                  checkNameRepitition() ? 'Name already exists' : null,
            ),
            ElevatedButton(
                onPressed: () {
                  validName ? analyzeSpeech() : null;
                },
                child: const Text('Analyze'))
          ]),
    );
  }
}
