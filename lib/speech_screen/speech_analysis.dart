import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'speech_controller.dart';
import 'package:video_player/video_player.dart';

class SpeechAnalysisPage extends StatefulWidget {
  final String recordingName;
  final String videoPath;

  const SpeechAnalysisPage(
      {super.key, required this.recordingName, required this.videoPath});

  @override
  State<SpeechAnalysisPage> createState() => _SpeechAnalysisPageState();
}

class _SpeechAnalysisPageState extends State<SpeechAnalysisPage> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    setState(() => videoPlayerController =
        VideoPlayerController.file(File(widget.videoPath)));
    videoPlayerController!.initialize();
    videoPlayerController!.play();
    videoPlayerController!.pause();
    videoPlayerController!.setVolume(2);
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        topBanner(context),
        const SizedBox(height: 10),
        videoPlayer(context),
        const Text('[TRANSCRIPTION HERE]'),
      ]),
    ));
  }

  Center topBanner(BuildContext context) {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFFFFC8B7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: IconButton(
                    onPressed: () => Get.find<SpeechController>()
                        .deletePrompt(widget.recordingName),
                    iconSize: 32,
                    color: Colors.black,
                    icon: const Icon(Icons.delete)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(children: [
                  const Spacer(),
                  const SizedBox(height: 40),
                  const Text('Public Speaking',
                      style: TextStyle(
                        fontSize: 30,
                      )),
                  Text(widget.recordingName),
                  const Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  iconSize: 32,
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_forward),
                ),
              )
            ],
          )),
    );
  }

  Column videoPlayer(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.75,
        child: VideoPlayer(videoPlayerController!),
      )
    ]);
  }
}
