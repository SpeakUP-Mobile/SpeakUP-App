import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../custom_global_widgets/user_info_widget.dart';
import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

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
              text: 'Profile',
              fontSize: 25,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 250, left: 35, right: 35, bottom: 30),
            child: Column(
              children: [
                InkWell(
                  onTap: () => controller.signOutUser(),
                  child: Container(
                      height: 85,
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
                      child: const Center(child: Text('Sign Out'))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
