import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../custom_global_widgets/user_info_widget.dart';
import 'interview_page.dart';

class InterviewHub extends StatelessWidget {
  const InterviewHub({super.key});

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
                InkWell(
                  onTap: () async {
                    Get.to(const InterviewPage());
                  },
                  child: Container(
                      alignment: Alignment.center,
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
                      child: const Text('Start new Interview')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
