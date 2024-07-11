import 'package:flutter/material.dart';
import 'package:public_speak_cac_2024/common_widgets.dart';
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
      bottomNavigationBar: bottomBanner(),
    );
  }

  Container bottomBanner() {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(CommonWidgets.motifImageURI),
          ),
          color: Color(0xffffc8b7),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 15, spreadRadius: 0)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
        height: 175,
        decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(CommonWidgets.motifImageURI),
            ),
            color: Color(0xffffc8b7),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 15, spreadRadius: 0)
            ],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      )
    ]);
  }
}
