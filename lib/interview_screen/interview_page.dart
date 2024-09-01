import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../custom_global_widgets/custom_dialog_button.dart';
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
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      recordingInfo(),
                      questionText(screenWidth),
                      const Spacer(),
                      interviewControls(context),
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
                      if (!controller.isPreviewLoading.value) {
                        return SizedBox(
                            width: screenWidth,
                            height: screenWidth *
                                controller.cameraController.value.aspectRatio,
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Obx(() {
                                  if (controller.isCameraFront.value) {
                                    return CameraPreview(
                                        controller.cameraController);
                                  } else {
                                    return CameraPreview(
                                        controller.cameraController);
                                  }
                                }),
                                Positioned(
                                  top: 160,
                                  left: 10,
                                  child: InkWell(
                                    onTap: () => controller.flipCamera(),
                                    child: Icon(Icons.flip_camera_ios_outlined,
                                        size: 32,
                                        color: controller.isRecording.value
                                            ? const Color.fromARGB(
                                                38, 135, 135, 135)
                                            : Colors.white),
                                  ),
                                ),
                              ],
                            ));
                      } else {
                        return const Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator());
                      }
                    })))));
  }

  Container recordingInfo() {
    return Container(
        height: 45,
        margin: const EdgeInsets.symmetric(horizontal: 45),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Obx(() {
            final int time = controller.isRecording.value
                ? controller.recordingSeconds.value
                : controller.questionTimes[controller.currentQuestion.value];
            final int minutes = (time ~/ 60);
            final String seconds =
                (time - minutes * 60).toString().padLeft(2, '0');
            return Text('${minutes.toString()}:$seconds',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
          }),
          const SizedBox(width: 10),
          Obx(() {
            if (controller.isRecording.value) {
              return Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xFF3B3B3B)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                    child: Row(children: [
                      Text('REC',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.circle, color: Colors.red, size: 20)
                    ]),
                  ));
            } else {
              return Container();
            }
          })
        ]));
  }

  SizedBox questionText(double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.85,
      child: Obx(
        () => Text(controller.questions[controller.currentQuestion.value],
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  Row interviewControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        InkWell(
            onTap: () => !controller.isRecording.value
                ? controller.currentQuestion.value != 0
                    ? controller.previousQuestion()
                    : Get.dialog(exitInterviewDialog(context))
                : null,
            child: Obx(
              () => Icon(
                Icons.arrow_back,
                size: 48,
                color: !controller.isRecording.value
                    ? Colors.black
                    : const Color.fromARGB(153, 183, 183, 183),
              ),
            )),
        const Spacer(flex: 3),
        InkWell(
            onTap: () => controller.isDoneRecording.value
                ? Get.dialog(retakeRecordingDialog(context))
                : controller.pressRecord(),
            child: Obx(() {
              if (controller.isDoneRecording.value) {
                return const Icon(Icons.replay, color: Colors.red, size: 48);
              } else {
                return Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        border: Border.all(
                            color: controller.isRecording.value
                                ? Colors.red
                                : Colors.black,
                            width: 5),
                        color: controller.isRecording.value
                            ? Colors.red
                            : Colors.black));
              }
            })),
        const Spacer(flex: 3),
        InkWell(
            onTap: () =>
                controller.currentQuestion.value != controller.numQuestions - 1
                    ? controller.nextQuestion()
                    : Get.dialog(viewResultsDialog(context)),
            child: Obx(
              () => Icon(Icons.arrow_forward,
                  size: 48,
                  color: controller.isDoneRecording.value
                      ? Colors.black
                      : const Color.fromARGB(153, 183, 183, 183)),
            )),
        const Spacer()
      ],
    );
  }

  Dialog exitInterviewDialog(BuildContext context) {
    return Dialog(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Exit Interview', style: TextStyle(fontSize: 32.0)),
              const SizedBox(height: 10),
              const Text('Are you sure you want to exit this interview',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              const Text('Your prgress WILL NOT be saved',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDialogButton(
                      text: 'Cacnel',
                      primaryColor: const Color(0xFF1C217F),
                      secondaryColor: const Color.fromARGB(255, 20, 24, 92),
                      onPressed: () => Get.back()),
                  const SizedBox(width: 15),
                  CustomDialogButton(
                      text: 'Exit',
                      primaryColor: Colors.red,
                      secondaryColor: const Color.fromARGB(255, 132, 0, 0),
                      onPressed: () => controller.exitInterview()),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  Dialog retakeRecordingDialog(BuildContext context) {
    return Dialog(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(children: [
                  const SizedBox(height: 20),
                  const Text('Re-do Question',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32.0)),
                  const SizedBox(height: 10),
                  const Text('Are you sure you want to re-record this question',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 5),
                  const Text('This action can not be undone',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomDialogButton(
                        text: 'Cacnel',
                        primaryColor: const Color(0xFF1C217F),
                        secondaryColor: const Color.fromARGB(255, 20, 24, 92),
                        onPressed: () => Get.back()),
                    const SizedBox(width: 15),
                    CustomDialogButton(
                        text: 'Retake',
                        primaryColor: Colors.red,
                        secondaryColor: const Color.fromARGB(255, 132, 0, 0),
                        onPressed: () => controller.retakeRecording()),
                  ])
                ]))));
  }

  Dialog viewResultsDialog(BuildContext context) {
    return Dialog(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Finsh Interview',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 32.0)),
            const SizedBox(height: 10),
            const Text('Are you sure you want to finish this interview?',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            const Text('The recordings can be acessed later.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomDialogButton(
                  text: 'Cacnel',
                  primaryColor: const Color.fromARGB(255, 113, 113, 113),
                  secondaryColor: const Color.fromARGB(255, 73, 73, 73),
                  onPressed: () => Get.back()),
              const SizedBox(width: 15),
              CustomDialogButton(
                  text: 'Finish',
                  primaryColor: const Color(0xFF1C217F),
                  secondaryColor: const Color.fromARGB(255, 20, 24, 92),
                  onPressed: () => controller.endInterview()),
            ])
          ],
        ),
      ),
    ));
  }
}
