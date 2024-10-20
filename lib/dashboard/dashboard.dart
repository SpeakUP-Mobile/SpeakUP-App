import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:speakup/profile_screen/profile_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../interview_screen/interview_page.dart';
import 'dashboard_controller.dart';
import '../recordings_screen/recordings_page.dart';
import '../explore_screen/explore_page.dart';

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
        appBar: controller.tabIndex == 0
            ? AppBar(
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                        const SizedBox(height: 1),
                        InkWell(
                          onTap: () =>
                              {Get.find<ProfileController>().signOutUser()},
                          child: GradientText(
                            textAlign: TextAlign.right,
                            Supabase.instance.client.auth.currentUser!
                                .userMetadata!['username'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 36),
                            colors: const [
                              Color(0xff8710D0),
                              Color(0xffFF18BE)
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              )
            : AppBar(
                shadowColor: const Color.fromARGB(70, 0, 0, 0),
                surfaceTintColor: Colors.white,
                elevation: 10,
                scrolledUnderElevation: 10,
                toolbarHeight: 117,
                title: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    softWrap: true,
                    "find advice for your next interview...",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color(0xFF401274)),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
        bottomNavigationBar: Container(
          height: 130,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(bottomNavBarRadius),
              topRight: Radius.circular(bottomNavBarRadius),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(30, 0, 0, 0),
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
                        onTap: () => controller.changeTabIndex(1),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              margin: const EdgeInsets.only(bottom: 5),
                              child: ImageIcon(
                                const AssetImage(
                                  "assets/icons/explore/explore.png",
                                ),
                                size: 30.0,
                                color: controller.tabIndex == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            Text(
                              'explore',
                              style: labelStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: controller.tabIndex == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                const Spacer(flex: 3),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 15),
                      child: InkWell(
                        child: Container(
                          height: 75,
                          width: 75,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Color.fromARGB(105, 0, 0, 0),
                                    spreadRadius: 0)
                              ],
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
                      onTap: () => controller.changeTabIndex(0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: ImageIcon(
                              const AssetImage(
                                  "assets/icons/profile/profile_selected.png"),
                              color: controller.tabIndex == 0
                                  ? Colors.black
                                  : Colors.grey,
                              size: 30.0,
                            ),
                          ),
                          Text(
                            /*Supabase.instance.client.auth.currentUser!
                                .userMetadata!['username']
                                .toString()
                                .toLowerCase()*/
                            "profile",
                            style: labelStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: controller.tabIndex == 0
                                  ? Colors.black
                                  : Colors.grey,
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
            ExplorePage(),
          ],
        ),
      );
    });
  }
}
