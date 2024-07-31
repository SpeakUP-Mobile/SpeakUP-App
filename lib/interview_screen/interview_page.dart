import 'package:flutter/material.dart';
import 'package:public_speak_cac_2024/custom_global_widgets/user_info_widget.dart';

class InterviewPage extends StatelessWidget {
  const InterviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70),
            alignment: AlignmentDirectional.topCenter,
            margin: const EdgeInsets.only(bottom: 13),
            child: const UserInfoWidget(
              text: 'Interviews',
              fontSize: 25,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 250, left: 35, right: 35, bottom: 30),
            child: Column(
              // Content
              children: [
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
                            blurRadius: 2.5),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
