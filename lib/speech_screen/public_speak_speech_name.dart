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
    File file = await _localFile;

    // Write the file
    print(newName);
    file = await file.writeAsString('videoName: $newName \n',
        mode: FileMode.append);
    file = await file.writeAsString('videoPath: ${widget.filePath} \n',
        mode: FileMode.append);
    file =
        await file.writeAsString('isInterview: true \n', mode: FileMode.append);
    return file;
  }

  Future<bool> get _isRepeat async {
    final path = await _localPath;

    return File('$path/$newName.metadata').exists();
  }

  checkNameRepitition() async {
    final path = await _localPath;

    final isRepeat = await _isRepeat;

    if (isRepeat) {
      validName = false;
      return true;
    } else {
      validName = true;
      return false;
    }
  }

  Future<List<String>> get _fileContents async {
    final file = await _localFile;

    return file.readAsLines();
  }

  analyzeSpeech() async {
    final file = await createMetadata();
    final fileContents = await _fileContents;
    Get.to(PublicSpeakSpeechAnalysis(fileName: fileContents[1].substring(11)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name this recording',
                    hintText: 'Untitled 1'),
                onChanged: (name) {
                  setState(() => newName = name);
                },
                validator: (name) => validName ? 'Name already exists' : null,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => analyzeSpeech(),
                    child: const Text('Analyze')),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () => Get.back(), child: const Text("Cancel"))
              ],
            )
          ]),
    );
  }
}
