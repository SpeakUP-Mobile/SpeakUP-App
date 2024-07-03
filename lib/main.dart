import 'package:flutter/material.dart';

void main() {
  runApp(const PublicSpeak());
}

class PublicSpeak extends StatelessWidget {
  const PublicSpeak({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Speak',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: false,
      ),
      home:
          const PublicSpeakHome(), // We will change this to the login page, for now its just home
    );
  }
}

class PublicSpeakHome extends StatelessWidget {
  const PublicSpeakHome({super.key});

  Stack userInfo() {
    double size = 130;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 85,
          width: 350,
          padding: const EdgeInsets.only(top: 20, right: 30),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Container(
              padding: const EdgeInsets.only(left: 150),
              child: const Text(
                'Good afternoon, [Name]',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              )),
        ),
        Container(
          margin: const EdgeInsets.only(right: 260),
          padding: const EdgeInsets.all(2),
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: 130,
            child: Container(
                decoration: const BoxDecoration(
                    // we can add an image later
                    shape: BoxShape.rectangle,
                    color: Color(0xffFFC8B7),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                    boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: -1, blurRadius: 5)
                ]))),
        Container(
          padding: const EdgeInsets.only(left: 20, top: 70),
          child: userInfo(),
        )
      ],
    ));
  }
}
