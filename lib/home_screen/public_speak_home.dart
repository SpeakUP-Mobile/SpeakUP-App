import 'package:flutter/material.dart';
import 'package:public_speak_cac_2024/custom_global_widgets/user_info_widget.dart';
import '../common_widgets.dart';

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
          CommonWidgets.topBanner(),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 70, right: 20),
            alignment: AlignmentDirectional.topCenter,
            margin: const EdgeInsets.only(bottom: 13),
            child: const UserInfoWidget(text: 'Good afternoon, [Name]'),
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
