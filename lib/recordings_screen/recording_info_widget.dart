import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class RecordingInfoWidget extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final bool isInterview;
  final int score;

  const RecordingInfoWidget(
      {super.key,
      required this.name,
      required this.date,
      required this.time,
      required this.isInterview,
      required this.score});

  deleteRecording() async {
    final localPath = await getApplicationDocumentsDirectory();
    final file = File('${localPath.path}/$name.metadata');
    final contents = await file.readAsLines();
    final videoPath = contents[1];
    final video = File(videoPath);
    await video.delete();
    await file.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 115,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 2.5,
              )
            ]),
        child: Row(children: [
          Container(
              width: 120,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(name, style: const TextStyle(fontSize: 20)),
            Text(date, style: const TextStyle(fontSize: 12)),
            Text(time, style: const TextStyle(fontSize: 12)),
            const Spacer(),
            recordingTags()
          ]),
        ]));
  }

  Row recordingTags() {
    return Row(
      children: [
        InkWell(
          onTap: () => deleteRecording(),
          child: Container(
            padding:
                const EdgeInsets.only(left: 7, right: 5, top: 3, bottom: 3),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5)
                ]),
            child: const Row(
              children: [
                // Text(
                //   "Delete",
                //   style: TextStyle(fontSize: 10),
                // ),
                Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 17,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text("$score/10",
                style: TextStyle(
                    fontSize: 10,
                    color: score > 5
                        ? const Color(0xFF00FF57)
                        : const Color(0xFFFF0000)))),
        const SizedBox(width: 5),
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              gradient: !isInterview
                  ? const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 176, 60, 248),
                        Color(0xffFF18BE)
                      ],
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF4F23FF), Color(0xFF8F00FF)]),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              boxShadow: const [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5)
              ]),
          child: Text(isInterview ? "Interview" : "Public Speech",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
