import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_speak_cac_2024/speech_screen/public_speak_speech_analysis.dart';

class PublicSpeakSpeechName extends StatefulWidget {
  final String filePath;

  const PublicSpeakSpeechName({super.key, required this.filePath});

  @override
  State<PublicSpeakSpeechName> createState() => _PublicSpeakSpeechNameState();
}

class _PublicSpeakSpeechNameState extends State<PublicSpeakSpeechName> {
  String newName = 'Untitled';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name this recording',
                  hintText: 'Untitled 1'),
              onSubmitted: (name) => setState(() => newName = name),
            ),
            ElevatedButton(
                onPressed: () {
                  File(widget.filePath).rename(newName);
                  Get.to(PublicSpeakSpeechAnalysis(
                    filePath: 'tmp/$newName' '.mov',
                  ));
                },
                child: const Text('Analyze'))
          ]),
    );
  }
}
