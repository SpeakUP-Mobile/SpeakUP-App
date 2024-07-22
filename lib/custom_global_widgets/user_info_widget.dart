import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class UserInfoWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool showName;
  final String name;

  const UserInfoWidget(
      {super.key,
      required this.text,
      required this.fontSize,
      this.name = "",
      this.showName = false});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 14, right: 20, bottom: 0),
          margin: const EdgeInsets.only(top: 27, left: 50, right: 25),
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
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 50),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    text,
                    style: TextStyle(fontSize: fontSize),
                    textAlign: TextAlign.right,
                  )),
              showName
                  ? Container(
                      padding: const EdgeInsets.only(left: 100),
                      alignment: AlignmentDirectional.centerEnd,
                      child: GradientText(
                        name,
                        colors: const [Color(0xff8710D0), Color(0xffFF18BE)],
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                        textAlign: TextAlign.right,
                      ))
                  : Container(),
            ],
          )),
      Container(
        margin: const EdgeInsets.only(
          right: 250,
          top: 8,
        ),
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
