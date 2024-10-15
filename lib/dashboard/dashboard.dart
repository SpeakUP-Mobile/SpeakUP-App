import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';
import '../recordings_screen/recordings_page.dart';
import '../interview_screen/interview_hub.dart';
import '../profile_screen/profile_page.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});

  final TextStyle labelStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  final double bottomNavBarRadius = 30;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardController());
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: const Color.fromARGB(102, 0, 0, 0),
          surfaceTintColor: Colors.white,
          elevation: 5,
          toolbarHeight: 100,
          title: const Text(
            textAlign: TextAlign.right,
            "Welcome Back",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
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
                InkWell(
                  onTap: () => controller.changeTabIndex(0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: ImageIcon(
                          AssetImage(
                            controller.tabIndex == 0
                                ? "assets/icons/home/home_selected_icon.png"
                                : "assets/icons/home/home_icon.png",
                          ),
                          size: 30.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Home',
                        style: labelStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => controller.changeTabIndex(2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 35,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: ImageIcon(
                          AssetImage(
                            controller.tabIndex == 2
                                ? "assets/icons/briefcase/briefcase_selected_icon.png"
                                : "assets/icons/briefcase/briefcase_icon.png",
                          ),
                          size: 30.0,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Interviews',
                        style: labelStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: controller.tabIndex,
          children: const [
            RecordingsPage(),
            InterviewHub(),
            ProfilePage(),
          ],
        ),
      );
    });
  }
}
