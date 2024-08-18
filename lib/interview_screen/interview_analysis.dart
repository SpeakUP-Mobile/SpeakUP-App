import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';

class InterviewAnalysis extends StatefulWidget {
  final String filePath;

  const InterviewAnalysis({super.key, required this.filePath});

  @override
  State<InterviewAnalysis> createState() => _InterviewAnalysisState();
}

class _InterviewAnalysisState extends State<InterviewAnalysis> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    setState(() => _videoPlayerController =
        VideoPlayerController.file(File(widget.filePath)));
    _videoPlayerController.init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
                onTap: () => Get.back(), child: const Icon(Icons.arrow_back))),
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            Center(
              child: GradientText('Interview #',
                  textAlign: TextAlign.center,
                  colors: const [Color(0xff8710D0), Color(0xffFF18BE)],
                  style: const TextStyle(
                      fontSize: 58, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),

          ]),
        ));
  }
}
