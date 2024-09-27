import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'recordings_controller.dart';
import "../custom_global_widgets/user_info_widget.dart";
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
            child: Obx(() => UserInfoWidget(
                  text: 'Good ${controller.getTime()},',
                  fontSize: 24,
                  name: controller.username.value,
                  showName: true,
                )),
          ),
        ]),
        Obx(() => filterButtons()),
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
              onPressed: () => Get.dialog(newRecordingDialog(context)),
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

  Container filterButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Container(
            height: 35,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
                color: controller.view.value == 0
                    ? Colors.white
                    : const Color.fromARGB(255, 222, 222, 222),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(255, 209, 209, 209),
                      spreadRadius: 0,
                      blurRadius: controller.view.value == 0 ? 5 : 0),
                ]),
            child: InkWell(
              onTap: () => controller.setView(0),
              child: const Text(
                "All",
                style: TextStyle(color: Colors.black),
              ),
            )),
        Container(
            height: 35,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              gradient: controller.view.value == 1
                  ? const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 176, 60, 248),
                        Color(0xffFF18BE)
                      ],
                    )
                  : const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 199, 199, 199),
                        Color.fromARGB(255, 199, 199, 199)
                      ],
                    ),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: InkWell(
              onTap: () => controller.setView(1),
              child: Text(
                "Public Speech",
                style: TextStyle(
                    color: controller.view.value == 1
                        ? Colors.white
                        : Colors.black),
              ),
            )),
        Container(
          height: 35,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            gradient: controller.view.value == 2
                ? const LinearGradient(
                    colors: [Color(0xFF4F23FF), Color(0xFF8F00FF)])
                : const LinearGradient(colors: [
                    Color.fromARGB(255, 199, 199, 199),
                    Color.fromARGB(255, 199, 199, 199)
                  ]),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: InkWell(
            onTap: () => controller.setView(2),
            child: Text('Interview',
                style: TextStyle(
                    color: controller.view.value == 2
                        ? Colors.white
                        : const Color.fromARGB(255, 0, 0, 0))),
          ),
        ),
      ]),
    );
  }

  Dialog newRecordingDialog(BuildContext context) {
    return Dialog(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        'Create a new recording to analyze (only interview works rn)',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      //TODO: Actually implement speech analysis
                        onTap: () => controller.clearMetadata(), //Im temporarily using this button to delete all metadata files
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color.fromARGB(51, 194, 194, 194)),
                            child: const Text('Speech',
                                style: TextStyle(fontSize: 16)))),
                    const SizedBox(height: 10),
                    InkWell(
                        onTap: () {
                          Get.to(const InterviewPage());
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color.fromARGB(51, 194, 194, 194)),
                            child: const Text('Interview',
                                style: TextStyle(fontSize: 16)))),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            )));
  }
}
