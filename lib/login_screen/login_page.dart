import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_global_widgets/custom_dialog_button.dart';
import 'login_controller.dart';
import 'third_party_login_button.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(alignment: AlignmentDirectional.topCenter, children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height + 5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/login_temp_background.jpeg'),
                fit: BoxFit.cover,
              ))),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: screenHeight * 0.20),
            welcomeTo(),
            const SizedBox(height: 20),
            speakup(screenWidth),
            SizedBox(height: screenHeight * 0.035),
            description(),
            SizedBox(height: screenHeight * 0.08),
            registerButton(context),
            const SizedBox(height: 15),
            loginButton(context),
            SizedBox(height: screenHeight * 0.04),
            //thirdPartyLoginButtons(),
          ]),
        ]),
      ),
    );
  }

  Text welcomeTo() {
    return const Text(
      '👋 Welcome to...',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Column speakup(double screenWidth) {
    return Column(
      children: [
        const Row(
          children: [
            Spacer(flex: 2),
            Text('speak',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF383DA8))),
            Spacer(flex: 5),
          ],
        ),
        const SizedBox(height: 3),
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

  Container registerButton(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
          ]),
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          backgroundColor: const WidgetStatePropertyAll<Color>(
              Color.fromARGB(255, 30, 35, 129)),
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
        onPressed: () {
          Get.lazyPut(() => LoginController());
          controller.resetWarningText();
          Get.dialog(registerDialog(context));
        },
      ),
    );
  }

  Container loginButton(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
          backgroundColor: const WidgetStatePropertyAll<Color>(
              Color.fromARGB(255, 255, 255, 255)),
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
        onPressed: () {
          controller.resetWarningText();
          Get.dialog(loginDialog(context));
        },
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

  registerDialog(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.cancel_rounded))),
                const Text('Register', style: TextStyle(fontSize: 32.0)),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE8E8E8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 7),
                            child: TextField(
                              maxLines: 1,
                              maxLength: 20,
                              decoration: const InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: 'Full Name',
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: Color(0xFFBFBFBF))),
                              onChanged: (username) =>
                                  controller.updateUsername(username),
                            )),
                        const SizedBox(height: 10),
                        Container(
                          height: 45,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE8E8E8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 7),
                          child: TextField(
                            enableSuggestions: false,
                            maxLines: 1,
                            maxLength: 50,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                counterText: '',
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'Email adress',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Color(0xFFBFBFBF))),
                            onChanged: (email) => controller.updateEmail(email),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE8E8E8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 7),
                            child: TextField(
                              maxLines: 1,
                              maxLength: 30,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: Color(0xFFBFBFBF))),
                              onChanged: (password) =>
                                  controller.updatePassword(password),
                            )),
                        const SizedBox(height: 10),
                        Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE8E8E8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 7),
                            child: TextField(
                              maxLines: 1,
                              maxLength: 30,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: 'Confirm your password',
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: Color(0xFFBFBFBF))),
                              onChanged: (confirmPassword) => controller
                                  .updateConfirmPassword(confirmPassword),
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                const Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text('By continuing, you agree to SpeakUP\'s',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Privacy Policy',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlueAccent)),
                              Text(' and ',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                              Text('Terms and Conditions',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlueAccent)),
                            ],
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 10),
                Obx(() => Text(controller.warningText.value,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ))),
                const SizedBox(height: 10),
                Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 65),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 2.5),
                        ]),
                    child: CustomDialogButton(
                      text: 'Done',
                      primaryColor: const Color(0xFF1C217F),
                      secondaryColor: const Color.fromARGB(255, 20, 24, 92),
                      onPressed: () => controller.registerUser(),
                      fontSize: 24,
                      bold: true,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginDialog(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.cancel_rounded))),
                const Text('Login', style: TextStyle(fontSize: 32.0)),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          height: 45,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE8E8E8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 7),
                          child: TextField(
                            enableSuggestions: false,
                            maxLines: 1,
                            maxLength: 50,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                counterText: '',
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'Email adress',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Color(0xFFBFBFBF))),
                            onChanged: (email) => controller.updateEmail(email),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Color(0xFFE8E8E8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 7),
                            child: TextField(
                              maxLines: 1,
                              maxLength: 30,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  counterText: '',
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 12, color: Color(0xFFBFBFBF))),
                              onChanged: (password) =>
                                  controller.updatePassword(password),
                            )),
                        const SizedBox(height: 10),
                      ],
                    )),
                const SizedBox(height: 5),
                Obx(() => Text(controller.warningText.value,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ))),
                const SizedBox(height: 10),
                Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 65),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0,
                              blurRadius: 2.5),
                        ]),
                    child: CustomDialogButton(
                      text: 'Login',
                      primaryColor: const Color(0xFF1C217F),
                      secondaryColor: const Color.fromARGB(255, 20, 24, 92),
                      onPressed: () => controller.loginUser(),
                      fontSize: 24,
                      bold: true,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
