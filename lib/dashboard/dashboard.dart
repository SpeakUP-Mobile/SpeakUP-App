import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../interview_screen/interview_page.dart';
import 'dashboard_controller.dart';
import '../recordings_screen/recordings_page.dart';
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
          shadowColor: const Color.fromARGB(70, 0, 0, 0),
          surfaceTintColor: Colors.white,
          elevation: 10,
          scrolledUnderElevation: 10,
          toolbarHeight: 117,
          title: Row(
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    textAlign: TextAlign.right,
                    "Welcome back,",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.right,
                    Supabase.instance.client.auth.currentUser!
                        .userMetadata!['username'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(width: 20),
            ],
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
                const Spacer(),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Center(
                      child: InkWell(
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
                    )),
                const Spacer(flex: 3),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 15),
                      child: InkWell(
                        child: Container(
                          height: 70,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF865BCE),
                                  Color(0xFF7D40FF),
                                  Color(0xFF7D40FF)
                                ],
                              )),
                          child: const Center(
                            child: Icon(
                              color: Colors.white,
                              Icons.add,
                              size: 45,
                            ),
                          ),
                        ),
                        onTap: () => Get.to(const InterviewPage()),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Center(
                    child: InkWell(
                      onTap: () => controller.changeTabIndex(1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: ImageIcon(
                              AssetImage(
                                controller.tabIndex == 1
                                    ? "assets/icons/briefcase/briefcase_selected_icon.png"
                                    : "assets/icons/briefcase/briefcase_icon.png",
                              ),
                              size: 30.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            Supabase.instance.client.auth.currentUser!
                                .userMetadata!['username'],
                            style: labelStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: controller.tabIndex,
          children: const [
            RecordingsPage(),
            ProfilePage(),
          ],
        ),
      );
    });
  }
}
