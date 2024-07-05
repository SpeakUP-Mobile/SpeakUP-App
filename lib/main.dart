import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
        useMaterial3: true,
      ),
      home:
          const PublicSpeakHome(), // We will change this to the login page, for now its just home
    );
  }
}

class PublicSpeakHome extends StatelessWidget {
  const PublicSpeakHome({super.key});

  Stack userInfo() {
    double size = 125;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 85,
          width: 350,
          padding: const EdgeInsets.only(top: 15, right: 30),
          margin: const EdgeInsets.only(top: 20),
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
                'Good afternoon, [Name]',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right,
              )),
        ),
        Container(
          margin: const EdgeInsets.only(right: 255),
          padding: const EdgeInsets.all(5),
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: .01,
                blurRadius: 6,
              ),
            ],
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: -1, blurRadius: 5)
              ]),
        ),
        body: Stack(
          children: [
            Container(
                height: 130,
                decoration: const BoxDecoration(
                    // we can add an image later
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://img.freepik.com/free-vector/abstract-blue-tone-memphis-patterned-social-template-vector_53876-140327.jpg")),
                    shape: BoxShape.rectangle,
                    color: Color(0xffFFC8B7),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, spreadRadius: -1, blurRadius: 5)
                    ])),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 70),
              margin: const EdgeInsets.only(bottom: 13),
              child: userInfo(),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 230, left: 35, right: 35, bottom: 30),
              child: Column(
                // Content
                children: [
                  // this is not a button, just a idea of what it could look like
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 2.5)
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
