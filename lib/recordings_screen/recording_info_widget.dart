import 'package:flutter/material.dart';

class RecordingInfoWidget extends StatelessWidget {
  final int recordingNumber;
  final String date;
  final String time;
  final bool isInterview;
  final int score;

  const RecordingInfoWidget(
      {super.key,
      required this.recordingNumber,
      required this.date,
      required this.time,
      required this.isInterview,
      required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('Recording $recordingNumber',
                style: const TextStyle(fontSize: 20)),
            Text(date),
            Text(time),
            const Spacer(),
            recordingTags()
          ]),
        ]));
  }

  Row recordingTags() {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text("$score/10",
                style: TextStyle(
                    color: score > 5
                        ? const Color(0xFF00FF57)
                        : const Color(0xFFFF0000)))),
        const SizedBox(width: 8),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: isInterview
                    ? const Color(0xFFB5DBFF)
                    : const Color(0xFFFFB5C2),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5)
                ]),
            child: Text(isInterview ? "Interview" : "Public Speech"))
      ],
    );
  }
}
