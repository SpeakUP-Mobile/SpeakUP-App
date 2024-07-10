import 'package:flutter/material.dart';
import 'third_party_login_buttons.dart';
import 'custom_login_button.dart';

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
        topBanner(),
        const SizedBox(height: 150),
        logoAndText(),
        const SizedBox(height: 150),
        const CustomLoginButton(text: 'Login'),
        const SizedBox(height: 20),
        const CustomLoginButton(text: 'Register'),
        const SizedBox(height: 40),
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Spacer(flex: 8),
          ThirdPartyLoginButton(image: 'assets/login_screen/google_icon.png'),
          Spacer(),
          ThirdPartyLoginButton(image: 'assets/login_screen/facebook_icon.png'),
          Spacer(),
          ThirdPartyLoginButton(image: 'assets/login_screen/apple_icon.png'),
          Spacer(flex: 8),
        ]),
      ]),
      bottomNavigationBar: Stack(children: [
        Container(
            height: 75,
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                    left: BorderSide(width: 20, color: Color(0xffffc8b7))),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/login_screen/bottom_banner.png'),
                ))),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Container(
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(209, 247, 199, 183),
            ),
          ),
        ),
      ]),
    );
  }

  Text logoAndText() {
    return const Text(
      'Logo + [APP NAME]',
      style: TextStyle(
        fontSize: 35,
      ),
      textAlign: TextAlign.center,
    );
  }

  Stack topBanner() {
    return Stack(children: [
      Container(
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xffffc8b7),
        ),
      ),
      Container(
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/login_screen/top_banner.png'),
            ),
            shape: BoxShape.rectangle,
          )),
    ]);
  }
}
