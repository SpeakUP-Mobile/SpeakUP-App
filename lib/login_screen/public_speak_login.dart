import 'package:flutter/material.dart';

class PublicSpeakLogin extends StatefulWidget {
  const PublicSpeakLogin({super.key});

  @override
  State<PublicSpeakLogin> createState() => _PublicSpeakLoginState();
}

class _PublicSpeakLoginState extends State<PublicSpeakLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        //TODO: Add an image to the top instead of just a sqare
        Container(
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xffFFC8B7),
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: -1, blurRadius: 5),
              ],
            )),
        const SizedBox(height: 150),
        const Text(
          'Login + [APP NAME]',
          style: TextStyle(
            fontSize: 35,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 150),
        Container(
          height: 50,
          width: 250,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
              ]),
          child: const Text(
            'Login',
          ),
        ),
      ]),
    );
  }
}
