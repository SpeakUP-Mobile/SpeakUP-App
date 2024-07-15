import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final String text;

  const UserInfoWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Container(
          height: 100,
          width: 350,
          padding: const EdgeInsets.only(top: 14, right: 30, bottom: 20),
          margin: const EdgeInsets.only(top: 27, left: 25),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0.01,
                  blurRadius: 6,
                )
              ]),
          child: Container(
              padding: const EdgeInsets.only(left: 100),
              child: Text(
                text,
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.right,
              ))),
      Container(
        margin: const EdgeInsets.only(right: 250, top: 8),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: .01, blurRadius: 6)
            ]),
        child: const CircleAvatar(
          radius: 60,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
              "https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg"),
        ),
      ),
    ]);
  }
}
