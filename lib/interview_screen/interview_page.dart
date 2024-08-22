import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'interview_page_controller.dart';

class InterviewPage extends GetView<InterviewPageController> {
  const InterviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => InterviewPageController());
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
              const SizedBox(height: 30),
              cameraPreview(screenWidth),
              const Spacer(),
              Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      SizedBox(
                        width: screenWidth * 0.85,
                        child: Obx(
                          () => Text(
                              controller
                                  .questions[controller.currentQuestion.value],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18)),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          InkWell(
                              onTap: () => controller.currentQuestion.value != 0
                                  ? controller.nextQuestion
                                  : Get.dialog(exitInterviewDialog()),
                              child: const Icon(
                                Icons.arrow_back,
                                size: 48,
                              )),
                          const Spacer(flex: 3),
                          InkWell(
                              onTap: () => controller.pressRecord(),
                              child: Obx(
                                () => Icon(
                                    controller.isDoneRecording.value
                                        ? Icons.replay
                                        : controller.isRecording.value
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_unchecked,
                                    color: Colors.red,
                                    size: 48),
                              )),
                          const Spacer(flex: 3),
                          InkWell(
                              onTap: () => controller.currentQuestion.value !=
                                      controller.numQuestions - 1
                                  ? controller.nextQuestion()
                                  : Get.dialog(viewResultsDialog()),
                              child: Obx(
                                () => Icon(Icons.arrow_forward,
                                    size: 48,
                                    color: controller.isDoneRecording.value
                                        ? Colors.black
                                        : const Color.fromARGB(
                                            153, 183, 183, 183)),
                              )),
                          const Spacer()
                        ],
                      ),
                      const Spacer(),
                    ],
                  ))
            ])));
  }

  SizedBox cameraPreview(double screenWidth) {
    return SizedBox(
        height: screenWidth,
        width: screenWidth,
        child: ClipRect(
            child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Obx(() {
                      if (controller.isCameraInitialized.value) {
                        return SizedBox(
                            width: screenWidth,
                            height: screenWidth *
                                controller.cameraController.value.aspectRatio,
                            child: CameraPreview(controller.cameraController));
                      } else {
                        return const Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator());
                      }
                    })))));
  }

  Dialog exitInterviewDialog() {
    return Dialog(
        child: Column(
      children: [
        const Text(
            'Are you sure you want to exit this interview (Your progress will not be saved)'),
        ElevatedButton(
            onPressed: () => controller.exitInterview(),
            child: const Text('Exit'))
      ],
    ));
  }

  Dialog viewResultsDialog() {
    return Dialog(
        child: Column(
      children: [
        const Text('Are you sure you want to finish this interview'),
        ElevatedButton(
            onPressed: () => controller.endInterview(),
            child: const Text('Yes'))
      ],
    ));
  }
}
