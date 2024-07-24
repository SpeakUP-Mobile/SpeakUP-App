import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';

class PublicSpeakSpeechAnalysis extends StatefulWidget {
  final String filePath;
  const PublicSpeakSpeechAnalysis({super.key, required this.filePath});

  @override
  State<PublicSpeakSpeechAnalysis> createState() =>
      _PublicSpeakSpeechAnalysisState();
}

class _PublicSpeakSpeechAnalysisState extends State<PublicSpeakSpeechAnalysis> {
  @override
  Widget build(BuildContext context) {
    final String fileName =
        widget.filePath.substring(5, widget.filePath.length - 4);
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Center(
        child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFFFFC8B7),
            ),
            child: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Spacer(),
              const SizedBox(height: 40),
              const Text('Public Speaking',
                  style: TextStyle(
                    fontSize: 30,
                  )),
              Text(fileName.toUpperCase()),
              const Spacer(),
            ]))),
      ),
      const SizedBox(
        height: 250,
      ),
      const Text('[VIDEO PLAYBACK HERE]'),
      const SizedBox(height: 300),
      const Text('[TRANSCRIPTION HERE]'),
    ]));
  }
}
