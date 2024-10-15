import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recordings_controller.dart';

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
    return GestureDetector(
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0,
                    blurRadius: 2.5,
                  )
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const Icon(Icons.more_vert)
                  ],
                ),
                Row(
                  children: [Text(date), const Text(' '), Text(time)],
                ),
                Container(
                    width: 120,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: thumbnailPath != ''
                            ? AssetImage(thumbnailPath)
                            : const AssetImage(
                                'assets/placeholder_thumbnail.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.grey,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ))
              ],
            )),
        onTap: () => controller.viewRecording(isInterview, name, date, time,
            score, videoPaths, questions, questionResults, llamaResults));
  }
}
