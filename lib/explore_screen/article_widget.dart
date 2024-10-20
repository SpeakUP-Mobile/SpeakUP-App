import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/explore_screen/explore_controller.dart';

class ArticleWidget extends GetView<ExploreController> {
  final String name;
  final String imgURI;
  final String content;

  const ArticleWidget(
      {super.key,
      required this.name,
      required this.content,
      required this.imgURI});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.only(left: 10, top: 10),
      height: 145,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgURI),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6), // Adjust the opacity to darken
              BlendMode.darken, // This blends the image with black to darken it
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
      child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          )),
    ));
  }
}
