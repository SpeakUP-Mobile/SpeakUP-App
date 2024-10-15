import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'recordings_controller.dart';
import "../recordings_screen/recording_info_widget.dart";
import '../interview_screen/interview_page.dart';

class RecordingsPage extends GetView<RecordingsController> {
  const RecordingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RecordingsController());
    return Scaffold(
      body: Column(children: [
        Stack(children: [
          Container(
            padding: const EdgeInsets.only(top: 70),
            alignment: AlignmentDirectional.topCenter,
            margin: const EdgeInsets.only(bottom: 15),
          ),
        ]),
        Obx(() {
          return SingleChildScrollView(
            child: Column(children: [
              for (RecordingInfoWidget recording in controller.recordings)
                if (controller.view.value == 0)
                  recording
                else if (controller.view.value == 1 && !recording.isInterview)
                  recording
                else if (controller.view.value == 2 && recording.isInterview)
                  recording
            ]),
          );
        })
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 15),
        child: SizedBox(
          height: 70,
          width: 70,
          child: FittedBox(
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360)),
              onPressed: () => Get.to(const InterviewPage()),
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
