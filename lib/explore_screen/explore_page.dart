import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/explore_screen/article_widget.dart';
import 'explore_controller.dart';

class ExplorePage extends GetView<ExploreController> {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExploreController());
    RxList<ArticleWidget> articles = controller.fullArticles;
    return Scaffold(
      body: SingleChildScrollView(
        // Allow scrolling
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30), // Top padding
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Obx(() {
                  return GridView.count(
                    shrinkWrap:
                        true, // Ensure GridView only takes the space it needs
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / .5, // Adjust aspect ratio as needed
                    children: articles,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
