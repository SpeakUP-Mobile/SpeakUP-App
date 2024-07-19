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
  int pageIndex = 1;
  final screens = [
    const PublicSpeakLogin(),
    const PublicSpeakHome(),
    const PublicSpeakRecordings(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          selectedLabelStyle: const TextStyle(color: Colors.white),
          currentIndex: pageIndex,
          items: [
            BottomNavigationBarItem(
              icon: ElevatedButton(
                child: const Icon(Icons.home),
                onPressed: () => setState(() => pageIndex = 1),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ElevatedButton(
                child: const Icon(Icons.folder),
                onPressed: () => setState(() => pageIndex = 2),
              ),
              label: 'Recordings',
            ),
          ]),
    );
  }
}
