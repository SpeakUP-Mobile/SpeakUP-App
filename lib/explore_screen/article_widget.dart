import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:speakup/explore_screen/explore_controller.dart';

class ArticleWidget extends GetView<ExploreController> {
  final String name;
  final String imgURI;
  final String content;
  final String type;

  const ArticleWidget(
      {super.key,
      required this.name,
      required this.content,
      required this.imgURI,
      required this.type});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => ExploreController(),
    );

    return GestureDetector(
        onTap: () => controller.viewArticle(name, content),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          padding: const EdgeInsets.only(left: 10, top: 10),
          height: 120,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgURI),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), // Adjust the opacity to darken
                  BlendMode
                      .darken, // This blends the image with black to darken it
                ),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(50, 0, 0, 0),
                  spreadRadius: 0,
                  blurRadius: 4,
                )
              ]),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  type,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  )),
              const Spacer(
                flex: 1,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 230, bottom: 10, left: 12),
                height: 30,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                ),
                child: const Text(
                  "Read Now",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF3E0E72),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
