import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_speak_cac_2024/common_widgets.dart';
import 'custom_login_button.dart';
import 'third_party_login_buttons.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.topCenter, children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/login_temp_background.jpeg'),
              fit: BoxFit.cover,
            ))),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: screenHeight * 0.2),
          const Text(
            '👋 Welcome to...',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Spacer(flex: 3),
              Text('Speak',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF383DA8))),
              Spacer(flex: 7),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: const Image(image: AssetImage('assets/speakup_logo.png')),
          ),
          SizedBox(height: screenHeight * 0.035),
          const Text(
            'You AI-enhanced',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Public Speaking & Interview Coach',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.035),
          Container(
            height: 50,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                ]),
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    const WidgetStatePropertyAll<Color>(Color(0x70C7B6E3)),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.grey[200];
                    }
                    return null;
                  },
                ),
              ),
              child: const Center(
                  child: Text('Get Started',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold))),
              onPressed: () => true,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            width: 300,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                ]),
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    const WidgetStatePropertyAll<Color>(Color(0xFF1C217F)),
                overlayColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.grey[200];
                    }
                    return null;
                  },
                ),
              ),
              child: const Center(
                  child: Text('Login', style: const TextStyle(fontSize: 18))),
              onPressed: () => true,
            ),
          ),
          const SizedBox(height: 20),
          thirdPartyLoginButtons(),
        ]),
      ]),
    );
  }

  Row thirdPartyLoginButtons() {
    return const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Spacer(flex: 8),
      ThirdPartyLoginButton(image: 'assets/login_screen/google_icon.png'),
      Spacer(),
      ThirdPartyLoginButton(image: 'assets/login_screen/facebook_icon.png'),
      Spacer(),
      ThirdPartyLoginButton(image: 'assets/login_screen/apple_icon.png'),
      Spacer(flex: 8),
    ]);
  }
}
