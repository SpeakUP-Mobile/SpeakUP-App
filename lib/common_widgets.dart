import 'package:flutter/material.dart';

class CommonWidgets {
  static const String motifImageURI =
      "https://img.freepik.com/free-vector/abstract-blue-tone-memphis-patterned-social-template-vector_53876-140327.jpg";

  static Container topBanner() {
    return Container(
        height: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(CommonWidgets.motifImageURI)),
          shape: BoxShape.rectangle,
          color: Color(0xffFFC8B7),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: -1, blurRadius: 5),
          ],
        ));
  }
}
