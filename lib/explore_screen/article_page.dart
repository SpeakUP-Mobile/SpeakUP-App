import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/explore_screen/explore_controller.dart';

class ArticlePage extends GetView<ExploreController> {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ExploreController());
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Container(
            margin: const EdgeInsets.only(right: 45),
            child: Text(
              Get.arguments[0],
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    Get.arguments[1],
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(50, 0, 0, 0),
                              spreadRadius: 0.5,
                              blurRadius: 1,
                            )
                          ]),
                      child: const Text(
                        textAlign: TextAlign.center,
                        "I'm done reading",
                        style: TextStyle(
                            color: Color(0xFF3A0E67),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
