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
    file = await file.writeAsString('$newName \n',
        mode: FileMode.append); //Speech name
    file = await file.writeAsString('${widget.filePath} \n',
        mode: FileMode.append); //Path of actual video
    file = await file.writeAsString('interview \n',
        mode: FileMode.append); //Interview or Speech
    file = await file.writeAsString('4 \n', mode: FileMode.append); //Rating
    return file;
  }

  Future<bool> get _isRepeat async {
    final path = await _localPath;

    return File('$path/$newName.metadata').exists();
  }

  Future<List<String>> get _fileContents async {
    final file = await _localFile;

    return file.readAsLines();
  }

  analyzeSpeech() async {
    final fileExists = await _isRepeat;
    if (!fileExists) {
      validName = true;
      await createMetadata();
      final fileContents = await _fileContents;
      Get.to(PublicSpeakSpeechAnalysis(fileName: fileContents[0]));
    } else {
      validName = false;
    }
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
