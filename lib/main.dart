import 'package:flutter/material.dart';
import 'common_widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 75,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 10)
              ]),
        ),
        body: Stack(
          children: [
            Container(
                height: 150,
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
              padding: const EdgeInsets.only(left: 20, top: 70, right: 20),
              alignment: AlignmentDirectional.topCenter,
              margin: const EdgeInsets.only(bottom: 13),
              child: CommonWidgets.userInfo(),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 250, left: 35, right: 35, bottom: 30),
              child: Column(
                // Content
                children: [
                  // this is not a button, just a idea of what it could look like
                  Container(
                    height: 165,
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
