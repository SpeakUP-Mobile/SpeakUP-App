import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'speak_up_controller.dart';
import 'recordings_screen/public_speak_recordings.dart';
import 'speech_screen/public_speak_speech.dart';
import 'interview_screen/public_speak_interview.dart';
import 'profile_screen/public_speak_profile.dart';

class SpeakUpApp extends StatelessWidget {
  const SpeakUpApp({super.key});

  final TextStyle labelStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  final double bottomNavBarRadius = 30;

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController = Get.put(
      LandingPageController(),
      permanent: false,
    );

    return Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(
        () => IndexedStack(
          index: landingPageController.tabIndex.value,
          children: const [
            PublicSpeakRecordings(),
            PublicSpeakSpeech(),
            PublicSpeakInterview(),
            PublicSpeakProfile(),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavigationMenu(
      BuildContext context, LandingPageController landingPageController) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1),
        ),
        child: Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(bottomNavBarRadius),
              topRight: Radius.circular(bottomNavBarRadius),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 226, 220, 220),
                blurRadius: 50,
                spreadRadius: .2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(bottomNavBarRadius),
              topRight: Radius.circular(bottomNavBarRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildBottomNavBarIcon(
                  "Home",
                  "assets/icons/home/home_icon.png",
                  "assets/icons/home/home_selected_icon.png",
                  landingPageController,
                  0,
                ),
                buildBottomNavBarIcon(
                  "Speeches",
                  "assets/icons/podium/podium_icon.png",
                  "assets/icons/podium/podium_selected_icon.png",
                  landingPageController,
                  1,
                ),
                buildBottomNavBarIcon(
                  "Interviews",
                  "assets/icons/briefcase/briefcase_icon.png",
                  "assets/icons/briefcase/briefcase_selected_icon.png",
                  landingPageController,
                  2,
                ),
                buildBottomNavBarIcon(
                  "Profile",
                  "assets/icons/home/home_icon.png",
                  "assets/icons/home/home_selected_icon.png",
                  landingPageController,
                  3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavBarIcon(
      String name,
      String inactiveAssetImage,
      String activeAssetImage,
      LandingPageController landingPageController,
      int index) {
    final bool isSelected = landingPageController.tabIndex.value == index;

    return InkWell(
      onTap: () => landingPageController.changeTabIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            margin: const EdgeInsets.only(
                bottom: 5), // Adjust for more spacing between icon and label
            child: ImageIcon(
              AssetImage(
                isSelected ? activeAssetImage : inactiveAssetImage,
              ),
              size: 30.0,
              color: Colors.black,
            ),
          ),
          Text(
            name,
            style: labelStyle.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
