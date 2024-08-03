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
  bool isVideoPaused = true;

  @override
  void initState() {
    super.initState();
    setState(() => videoPlayerController =
        VideoPlayerController.file(File(widget.videoPath)));
    videoPlayerController!.initialize();
    videoPlayerController!.play();
    setState(() => isVideoPaused = false);
    videoPlayerController!.setVolume(2);
    videoPlayerController!.setLooping(true);
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
        videoPlayer(context),
      ]),
    ));
  }

  Center topBanner(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xFFFFC8B7),
        ),
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
    );
  }

  Column videoPlayer(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.65,
        child: VideoPlayer(videoPlayerController!),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      videoPlayerControls(),
    ]);
  }

  Row videoPlayerControls() {
    return Row(
      children: [
        const Spacer(),
        IconButton(
            iconSize: 45,
            onPressed: () =>
                Get.find<SpeechController>().deletePrompt(widget.recordingName),
            icon: const Icon(Icons.delete)),
        const Spacer(),
        IconButton(
            onPressed: () {
              if (isVideoPaused) {
                videoPlayerController!.play();
                setState(() => isVideoPaused = false);
              } else {
                videoPlayerController!.pause();
                setState(() => isVideoPaused = true);
              }
            },
            iconSize: 45,
            icon: Icon(isVideoPaused ? Icons.play_circle : Icons.pause_circle)),
        const Spacer(),
        IconButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          iconSize: 45,
          icon: const Icon(Icons.arrow_forward),
        ),
        const Spacer(),
      ],
    );
  }
}
