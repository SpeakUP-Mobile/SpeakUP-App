// import 'package:flutter/material.dart';
// import '../speech_upload_screen/public_speak_speech.dart';
// // ignore: unused_import
// import 'login_screen/public_speak_login.dart';
// import 'home_screen/public_speak_home.dart';
// import 'recordings_screen/public_speak_recordings.dart';

// class SpeakUpApp extends StatefulWidget {
//   const SpeakUpApp({super.key});

//   @override
//   State<SpeakUpApp> createState() => _SpeakUpAppState();
// }

// class _SpeakUpAppState extends State<SpeakUpApp> {
//   int currentIndex = 0;
//   Widget currentScreen = const PublicSpeakHome();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void tapAction() {
//     switch (currentIndex) {
//       case 0:
//         return setState(() => currentScreen = const PublicSpeakRecordings());
//       case 1:
//         return setState(() => currentScreen = const PublicSpeakSpeech());
//       case 2:
//         return setState(() => currentScreen = const PublicSpeakRecordings());
//       case 3:
//         return setState(() => currentScreen = const PublicSpeakRecordings());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: currentScreen,
//       bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           unselectedItemColor: const Color.fromARGB(255, 53, 53, 53),
//           selectedItemColor: Colors.black,
//           unselectedIconTheme:
//               const IconThemeData(color: Color.fromARGB(255, 53, 53, 53)),
//           selectedIconTheme: const IconThemeData(color: Colors.black),
//           iconSize: 10,
//           currentIndex: currentIndex,
//           onTap: (index) {
//             setState(() => currentIndex = index);
//             tapAction();
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Image(
//                   height: 20,
//                   image: AssetImage('assets/icons/history_icon.png')),
//               label: 'History',
//             ),
//             BottomNavigationBarItem(
//               icon: Image(
//                   height: 20,
//                   image: AssetImage('assets/icons/podium_icon.png')),
//               label: 'Public Speaking',
//             ),
//             BottomNavigationBarItem(
//               icon: Image(
//                   height: 20,
//                   image: AssetImage('assets/icons/briefcase_icon.png')),
//               label: 'Interview',
//             ),
//             BottomNavigationBarItem(
//               icon: Image(
//                   height: 20,
//                   image: AssetImage('assets/icons/profile_icon.png')),
//               label: 'Ram Patel',
//             ),
//           ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'speak_up_controller.dart';
import 'recordings_screen/public_speak_recordings.dart';
import 'speech_screen/public_speak_speech.dart';
import 'interview_screen/public_speak_interview.dart';
import 'profile_screen/public_speak_profile.dart';

class SpeakUpApp extends StatelessWidget {
  SpeakUpApp({super.key});

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: SizedBox(
          height: 90,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black.withOpacity(0.5),
            selectedItemColor: Colors.black,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 7),
                  child: const Icon(
                    Icons.home,
                    size: 20.0,
                  ),
                ),
                label: 'Home',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 7),
                  child: const Icon(
                    Icons.speaker,
                    size: 20.0,
                  ),
                ),
                label: 'Public Speaking',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 7),
                  child: const Icon(
                    Icons.location_history,
                    size: 20.0,
                  ),
                ),
                label: 'Interviews',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 7),
                  child: const Icon(
                    Icons.person_3,
                    size: 20.0,
                  ),
                ),
                label: 'Profile',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    return Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: const [
              PublicSpeakRecordings(),
              PublicSpeakSpeech(),
              PublicSpeakInterview(),
              PublicSpeakProfile(),
            ],
          )),
    );
  }
}
