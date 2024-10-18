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
              padding: const EdgeInsets.only(top: 50), // Top padding
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Obx(() {
                  return GridView.count(
                    shrinkWrap:
                        true, // Ensure GridView only takes the space it needs
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1 / 0.9, // Adjust aspect ratio as needed
                    children: controller.recordings,
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
