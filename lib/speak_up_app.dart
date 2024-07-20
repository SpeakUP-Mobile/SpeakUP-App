import 'package:flutter/material.dart';
import '../speech_upload_screen/public_speak_speech.dart';
// ignore: unused_import
import 'login_screen/public_speak_login.dart';
import 'home_screen/public_speak_home.dart';
import 'recordings_screen/public_speak_recordings.dart';

class SpeakUpApp extends StatefulWidget {
  const SpeakUpApp({super.key});

  @override
  State<SpeakUpApp> createState() => _SpeakUpAppState();
}

class _SpeakUpAppState extends State<SpeakUpApp> {
  int currentIndex = 0;
  Widget currentScreen = const PublicSpeakHome();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void tapAction() {
    switch (currentIndex) {
      case 0:
        return setState(() => currentScreen = const PublicSpeakRecordings());
      case 1:
        return setState(() => currentScreen = const PublicSpeakSpeech());
      case 2:
        return setState(() => currentScreen = const PublicSpeakRecordings());
      case 3:
        return setState(() => currentScreen = const PublicSpeakRecordings());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color.fromARGB(255, 53, 53, 53),
          selectedItemColor: Colors.black,
          unselectedIconTheme:
              const IconThemeData(color: Color.fromARGB(255, 53, 53, 53)),
          selectedIconTheme: const IconThemeData(color: Colors.black),
          iconSize: 10,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
            tapAction();
          },
          items: const [
            BottomNavigationBarItem(
              icon: Image(
                  height: 20,
                  image: AssetImage('assets/icons/history_icon.png')),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Image(
                  height: 20,
                  image: AssetImage('assets/icons/podium_icon.png')),
              label: 'Public Speaking',
            ),
            BottomNavigationBarItem(
              icon: Image(
                  height: 20,
                  image: AssetImage('assets/icons/briefcase_icon.png')),
              label: 'Interview',
            ),
            BottomNavigationBarItem(
              icon: Image(
                  height: 20,
                  image: AssetImage('assets/icons/profile_icon.png')),
              label: 'Ram Patel',
            ),
          ]),
    );
  }
}
