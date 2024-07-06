import 'package:flutter/material.dart';

class CommonWidgets {
  static Stack userInfo() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 100,
          width: 350,
          padding: const EdgeInsets.only(top: 22, right: 30),
          margin: const EdgeInsets.only(top: 27, left: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: .01,
                blurRadius: 6,
              ),
            ],
          ),
          child: Container(
              padding: const EdgeInsets.only(left: 150),
              child: const Text(
                'Good afternoon, [NameNameName]',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              )),
        ),
        Container(
          margin: const EdgeInsets.only(right: 210),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: .01, blurRadius: 6)
              ]),
          child: const CircleAvatar(
            radius: 70,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg"),
          ),
        ),
      ],
    );
  }
}
