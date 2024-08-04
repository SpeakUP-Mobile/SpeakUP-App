import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'third_party_login_button.dart';
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
          SizedBox(height: screenHeight * 0.18),
          welcomeTo(),
          const SizedBox(height: 10),
          speakup(screenWidth),
          SizedBox(height: screenHeight * 0.035),
          description(),
          SizedBox(height: screenHeight * 0.04),
          registerButton(),
          const SizedBox(height: 10),
          loginButton(),
          SizedBox(height: screenHeight * 0.04),
          thirdPartyLoginButtons(),
        ]),
      ]),
    );
  }

  Text welcomeTo() {
    return const Text(
      '👋 Welcome to...',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Column speakup(double screenWidth) {
    return Column(
      children: [
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
      ],
    );
  }

  Column description() {
    return const Column(
      children: [
        Text(
          'You AI-enhanced',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'Public Speaking & Interview Coach',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Container registerButton() {
    return Container(
      height: 50,
      width: 300,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
          ]),
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          backgroundColor:
              const WidgetStatePropertyAll<Color>(Color(0xFF1C217F)),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color.fromARGB(255, 20, 24, 92);
              }
              return null;
            },
          ),
        ),
        child: const Center(
            child: Text('Get Started',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        onPressed: () => controller.registerPrompt(),
      ),
    );
  }

  Container loginButton() {
    return Container(
      height: 50,
      width: 300,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
          ]),
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
          backgroundColor:
              const WidgetStatePropertyAll<Color>(Color(0x70C7B6E3)),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color.fromARGB(111, 158, 144, 181);
              }
              return null;
            },
          ),
        ),
        child: const Center(
            child: Text('Log In',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        onPressed: () => true,
      ),
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
