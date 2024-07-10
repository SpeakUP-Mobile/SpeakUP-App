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
        Stack(children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xffFFBEB0),
            ),
          ),
          Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/login_screen_top.png'),
                ),
                shape: BoxShape.rectangle,
              )),
        ]),
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
          height: 35,
          width: 250,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
              ]),
          child: const Center(
            child: Text(
              'Login',
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 35,
          width: 250,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
              ]),
          child: const Center(
            child: Text('Register'),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
          height: 75,
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/login_screen_bottom.png'),
              ))),
    );
  }
}
