import 'package:flutter/material.dart';
import '../custom_global_widgets/user_info_widget.dart';
import '../common_widgets.dart';

class PublicSpeakSpeech extends StatefulWidget {
  const PublicSpeakSpeech({super.key});

  @override
  State<PublicSpeakSpeech> createState() => _PublicSpeakSpeechState();
}

class _PublicSpeakSpeechState extends State<PublicSpeakSpeech> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(children: [
          CommonWidgets.topBanner(),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 70, right: 20),
            alignment: AlignmentDirectional.centerEnd,
            child: const UserInfoWidget(text: 'Public Speaking', fontSize: 24),
          ),
        ]),
        const SizedBox(height: 20),
        GestureDetector(
          child: Container(
              height: 165,
              width: 360,
              alignment: AlignmentDirectional.center,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                  ]),
              child: const Text('Upload Speech')),
          onTap: () {
            //Allow user to upload video
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          child: Container(
              height: 165,
              width: 360,
              alignment: AlignmentDirectional.center,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                  ]),
              child: const Text('Record Speech')),
          onTap: () {
            //Allow user to record video
          },
        ),
      ]),
    );
  }
}
