import 'package:flutter/material.dart';

class PublicSpeakSpeechAnalysis extends StatefulWidget {
  final String fileName;
  const PublicSpeakSpeechAnalysis({super.key, required this.fileName});

  @override
  State<PublicSpeakSpeechAnalysis> createState() =>
      _PublicSpeakSpeechAnalysisState();
}

class _PublicSpeakSpeechAnalysisState extends State<PublicSpeakSpeechAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Center(
        child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xFFFFC8B7),
            ),
            child: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Spacer(),
              const SizedBox(height: 40),
              const Text('Public Speaking',
                  style: TextStyle(
                    fontSize: 30,
                  )),
              Text(widget.fileName),
              const Spacer(),
            ]))),
      ),
      const SizedBox(
        height: 250,
      ),
      const Text('[VIDEO PLAYBACK HERE]'),
      const SizedBox(height: 300),
      const Text('[TRANSCRIPTION HERE]'),
    ]));
  }
}
