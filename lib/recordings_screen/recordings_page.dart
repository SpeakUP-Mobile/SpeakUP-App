import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'recordings_controller.dart';

class RecordingsPage extends GetView<RecordingsController> {
  const RecordingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RecordingsController());
    return Scaffold(
      body: SingleChildScrollView(
        // Allow scrolling
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30), // Top padding
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Obx(() {
                  return controller.recordings.isNotEmpty
                      ? GridView.count(
                          shrinkWrap:
                              true, // Ensure GridView only takes the space it needs
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio:
                              1.07954545 / 1, // Adjust aspect ratio as needed
                          children: controller.recordings)
                      : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.28,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "hey there!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "start your first practice interview!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Image(
                              image: AssetImage("assets/DoodleArrow.png"),
                              width: 80,
                            )
                          ],
                        );
                }),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 15, right: 15),
      //   child: SizedBox(
      //     height: 70,
      //     width: 70,
      //     child: FittedBox(
      //       child: FloatingActionButton(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(360)),
      //         onPressed: () => Get.to(const InterviewPage()),
      //         child: const Icon(
      //           Icons.add,
      //           size: 30,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
