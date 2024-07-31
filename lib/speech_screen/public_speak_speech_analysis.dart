import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PublicSpeakSpeechAnalysis extends StatefulWidget {
  final String fileName;
  const PublicSpeakSpeechAnalysis({super.key, required this.fileName});

  @override
  State<PublicSpeakSpeechAnalysis> createState() =>
      _PublicSpeakSpeechAnalysisState();
}

class _PublicSpeakSpeechAnalysisState extends State<PublicSpeakSpeechAnalysis> {
  deletePrompt() {
    Get.defaultDialog(
      title: 'Delete',
      middleText: 'Are you sure you want to delete ${widget.fileName}',
      backgroundColor: Colors.grey,
      textConfirm: "Delete",
      textCancel: "Cancel",
      onConfirm: deleteFile(),
      barrierDismissible: false,
      radius: 50,
    );
  }

  deleteFile() async {
    final localPath = await getApplicationDocumentsDirectory();
    final file = File('$localPath/${widget.fileName}.mov');
    final contents = await file.readAsLines();
    final videoPath = contents[1];
    final video = File(videoPath);
    await video.delete();
    file.delete();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Stack(
        children: [
          Center(
            child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xFFFFC8B7),
                ),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      const Spacer(),
                      const SizedBox(height: 40),
                      const Text('Public Speaking',
                          style: TextStyle(
                            fontSize: 30,
                          )),
                      Text(widget.fileName),
                      const Spacer(),
                    ]))),
          ),
          Container(
            margin: const EdgeInsets.only(top: 52, left: 10),
            child: IconButton(
                onPressed: () {
                  deletePrompt();
                },
                iconSize: 32,
                color: Colors.black,
                icon: const Icon(Icons.delete)),
          ),
        ],
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
