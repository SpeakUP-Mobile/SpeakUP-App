import 'package:flutter/material.dart';
import 'speak_up_app.dart';

void main() {
  runApp(const PublicSpeak());
}

class PublicSpeak extends StatelessWidget {
  const PublicSpeak({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeakUP',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: "Poppins",
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: SpeakUpApp(),
      //const PublicSpeakLogin(),
      // const PublicSpeakHome(),
      //const PublicSpeakRecordings(),
    );
  }
}
