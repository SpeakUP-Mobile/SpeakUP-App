import 'package:flutter/material.dart';
import 'login_screen/public_speak_login.dart';

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
      home:
          //const PublicSpeakHome(),
          const PublicSpeakLogin(),
    );
  }
}
