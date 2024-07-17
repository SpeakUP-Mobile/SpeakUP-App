import 'package:flutter/material.dart';
// ignore: unused_import
import 'login_screen/public_speak_login.dart';
// ignore: unused_import
import 'home_screen/public_speak_home.dart';
// ignore: unused_import
import 'recordings_screen/public_speak_recordings.dart';

void main() {
  runApp(const PublicSpeak());
}

class PublicSpeak extends StatelessWidget {
  const PublicSpeak({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Speak',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: // const PublicSpeakLogin(),
          // const PublicSpeakHome(),
          const PublicSpeakRecordings(),
    );
  }
}
