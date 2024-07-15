import 'package:flutter/material.dart';

class RecordingInfoWidget extends StatelessWidget {
  const RecordingInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 25),
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
            const Text('Recording 1', style: TextStyle(fontSize: 20)),
            const Text('January 1st, 2024'),
            const Text('18:53'),
            const Spacer(),
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Text("9/10",
                        style: TextStyle(color: Color(0xFF00FF57)))),
                const SizedBox(width: 5),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFB5C2),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 2.5)
                        ]),
                    child: const Text('Public Speech'))
              ],
            )
          ]),
        ]));
  }
}
