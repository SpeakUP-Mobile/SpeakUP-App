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
                    Text(name,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: 11,
                    ),
                    InkWell(
                      onTap: () {
                        controller.deleteRecording(
                            name, videoPaths, thumbnailPath);
                      },
                      child: const Icon(Icons.more_vert),
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
                    width: 16 * 8.5,
                    height: 9 * 8.5,
                    margin: const EdgeInsets.only(top: 10),
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
}
