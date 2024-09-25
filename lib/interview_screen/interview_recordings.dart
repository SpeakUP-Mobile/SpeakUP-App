import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';
import 'interview_recordings_controller.dart';

class InterviewRecordings extends GetView<InterviewRecordingsController> {
  const InterviewRecordings({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => InterviewRecordingsController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            bottom: false,
            child: Column(children: [
              const SizedBox(height: 10),
              Center(
                child: GradientText(
                  'Interview',
                  colors: const [Color(0xff8710D0), Color(0xffFF18BE)],
                  style: const TextStyle(
                      fontSize: 58, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(children: [
                    const SizedBox(height: 30),
                    videoPlayer(context),
                    const Spacer(),
                    videoPlayerControls(context)
                  ])),
            ])));
  }

  Container videoPlayerControls(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white),
        child: Column(
          children: [
            const SizedBox(height: 25),
            questionNumber(),
            const Spacer(),
            question(context),
            const Spacer(),
            interviewControls(context),
            const Spacer(),
          ],
        ));
  }

  SizedBox videoPlayer(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: ClipRect(
          child: OverflowBox(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Obx(() => controller
                      .videoController.value.value.isInitialized
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width *
                          controller.videoController.value.value.aspectRatio,
                      child: VideoPlayer(controller.videoController.value))
                  : const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator())),
            ),
          ),
        ));
  }

  Container questionNumber() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: Color.fromARGB(208, 218, 218, 218)),
        child: Obx(() => Text(
            '${controller.currentQuestion.value}/${controller.questions.length}',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5))));
  }

  Padding question(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Obx(() => InkWell(
              child: Icon(Icons.arrow_back,
                  size: 32,
                  color: controller.currentQuestion.value > 1
                      ? Colors.black
                      : const Color(0x50000000)),
              onTap: () => controller.previousQuestion())),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Obx(
              () => Text(
                  controller.questions[controller.currentQuestion.value - 1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
          const Spacer(),
          Obx(() => InkWell(
              child: Icon(Icons.arrow_forward,
                  size: 32,
                  color: controller.currentQuestion.value <
                          controller.questions.length
                      ? Colors.black
                      : const Color(0x50000000)),
              onTap: () => controller.nextQuestion())),
        ],
      ),
    );
  }

  Column interviewControls(BuildContext context) {
    return Column(
      children: [
        //TODO: Video Bar
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(),
          InkWell(
              child: const Icon(Icons.arrow_back, size: 48),
              onTap: () => Get.back()),
          const Spacer(),
          Obx(() => InkWell(
              child: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                  size: 48),
              onTap: () => controller.isPlaying.value
                  ? controller.pauseVideo()
                  : controller.playVideo())),
          const Spacer(),
          InkWell(
              child: const Icon(Icons.replay, size: 48),
              onTap: () => controller.replayVideo()),
          const Spacer(),
        ])
      ],
    );
  }
}
