import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recordings_controller.dart';
import 'dart:io';

class RecordingInfoWidget extends GetView<RecordingsController> {
  final String name;
  final String date;
  final String time;
  final bool isInterview;
  final List<String> videoPaths;
  final int score;
  final String thumbnailPath;
  final List<String> questions;
  final List<List<int>> questionResults;
  final List<String> llamaResults;

  const RecordingInfoWidget({
    super.key,
    required this.name,
    required this.date,
    required this.time,
    required this.isInterview,
    required this.videoPaths,
    required this.score,
    required this.thumbnailPath,
    required this.questions,
    required this.questionResults,
    required this.llamaResults,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle reg = const TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
    return GestureDetector(
        child: Container(
            width: MediaQuery.of(context).size.width / 2 - 20,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            height: 145,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    spreadRadius: 0,
                    blurRadius: 4,
                  )
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        name.length < 10 ? name : '${name.substring(0, 11)}...',
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      child: MenuAnchor(
                        menuChildren: <Widget>[
                          MenuItemButton(
                            onPressed: () {
                              controller.currentInterview = name;
                              Get.dialog(renameDialog(context));
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.drive_file_rename_outline_rounded),
                                SizedBox(width: 10),
                                Text('Rename'),
                              ],
                            ),
                          ),
                          MenuItemButton(
                            onPressed: () => controller.deleteRecording(
                                name, videoPaths, thumbnailPath),
                            child: const Row(
                              children: [
                                Icon(Icons.delete),
                                SizedBox(width: 10),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                        builder: (_, MenuController controller, Widget? child) {
                          return InkWell(
                              onTap: () {
                                if (controller.isOpen) {
                                  controller.close();
                                } else {
                                  controller.open();
                                }
                              },
                              child: const Icon(Icons.more_vert, size: 30));
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(style: reg, date),
                    Text(style: reg, ' '),
                    Text(style: reg, time)
                  ],
                ),
                Container(
                    width: 16 * 9.5,
                    height: 9 * 9.5,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(thumbnailPath)),
                        fit: BoxFit.cover,
                      ),
                      color: const Color.fromARGB(28, 158, 158, 158),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ))
              ],
            )),
        onTap: () => controller.viewRecording(isInterview, name, date, time,
            score, videoPaths, questions, questionResults, llamaResults));
  }

  renameDialog(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.23,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text('Rename "$name"',
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.w900)),
              const SizedBox(height: 20),
              Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: const BoxDecoration(
                      color: Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  padding: const EdgeInsets.only(left: 15, right: 30, top: 7),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Name',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(117, 0, 0, 0),
                              fontWeight: FontWeight.w900)),
                      const SizedBox(height: 10),
                      TextField(
                        maxLines: 1,
                        maxLength: 30,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                        decoration: const InputDecoration(
                          counterText: '',
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Interview 1',
                          hintStyle: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900),
                        ),
                        onChanged: (newName) =>
                            controller.newInterviewName = newName,
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              Text(controller.renameError.value,
                  style: const TextStyle(color: Colors.red, fontSize: 3)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () => Get.back(),
                      child: const Text('Cancel',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w900))),
                  const SizedBox(width: 20),
                  InkWell(
                      onTap: () => controller.checkName(),
                      child: const Text('Rename',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w900))),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
