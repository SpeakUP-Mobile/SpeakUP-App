import 'package:flutter/material.dart';
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
        return setState(() => currentScreen = const PublicSpeakHome());
      case 1:
        return setState(() => currentScreen = const PublicSpeakRecordings());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Color.fromARGB(255, 53, 53, 53),
          selectedItemColor: Colors.black,
          unselectedIconTheme:
              const IconThemeData(color: Color.fromARGB(255, 53, 53, 53)),
          selectedIconTheme: const IconThemeData(color: Colors.black),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
            tapAction();
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'History',
            ),
          ]),
    );
  }
}
