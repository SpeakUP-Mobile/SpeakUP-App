import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'recordings_controller.dart';
import "../custom_global_widgets/user_info_widget.dart";
import "../recordings_screen/recording_info_widget.dart";

class RecordingsPage extends GetView<RecordingsController> {
  const RecordingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Stack(children: [
        Container(
          padding: const EdgeInsets.only(top: 70),
          alignment: AlignmentDirectional.topCenter,
          margin: const EdgeInsets.only(bottom: 15),
          child: Obx(() => UserInfoWidget(
                text: 'Good Morning,',
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
    ]));
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
}
