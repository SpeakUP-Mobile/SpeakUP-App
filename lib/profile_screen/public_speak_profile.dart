import 'package:flutter/material.dart';

class PublicSpeakProfile extends StatelessWidget {
  const PublicSpeakProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
