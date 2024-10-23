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
            height: (MediaQuery.of(context).size.width / 2 - 20) * 0.92631579,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                        calcTextSize(name, const TextStyle(fontSize: 16.5))
                                    .width <=
                                9
                            ? name
                            : '${name.substring(0, 9)}...',
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 16.5, fontWeight: FontWeight.w900)),
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
                              child: const Icon(Icons.more_vert, size: 24));
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
                    width: MediaQuery.of(context).size.width * 0.3,
                    height:
                        MediaQuery.of(context).size.width * 0.3 * 0.56333333,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(thumbnailPath)),
                        fit: BoxFit.cover,
                      ),
                      color: const Color.fromARGB(28, 158, 158, 158),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    )),
              ],
            )),
        onTap: () => controller.viewRecording(isInterview, name, date, time,
            score, videoPaths, questions, questionResults, llamaResults));
  }

  Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      //ignore: deprecated_member_use
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    return textPainter.size;
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
