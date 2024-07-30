import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'speak_up_app.dart';

void main() {
  runApp(const PublicSpeak());
}

class PublicSpeak extends StatelessWidget {
  const PublicSpeak({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SpeakUP',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: "Poppins",
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home:
          //const PublicSpeakSpeechAnalysis(
          //  filePath: '/tmp/test.mov',
          //)
          //const PublicSpeakSpeechName(),
          const SpeakUpApp(),
      //const PublicSpeakLogin(),
      // const PublicSpeakHome(),
      //const PublicSpeakRecordings(),
    );
  }
}
