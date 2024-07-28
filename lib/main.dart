import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_speak_cac_2024/speech_screen/public_speak_speech_analysis.dart';
import 'package:public_speak_cac_2024/speech_screen/public_speak_speech_name.dart';
import 'speak_up_app.dart';
import 'dart:io';

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
