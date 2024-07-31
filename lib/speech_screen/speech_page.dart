import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:public_speak_cac_2024/speech_screen/speech_name.dart';
import '../custom_global_widgets/user_info_widget.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({super.key});

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  final double buttonHorizontalMargin = 25;
  final double buttonHeight = 100;

  getVideoFile(ImageSource sourceImage) async {
    final videoFile = await ImagePicker().pickVideo(source: sourceImage);

    if (videoFile != null) {
      Get.to(SpeechNamePage(filePath: videoFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(children: [
          Container(
            padding: const EdgeInsets.only(top: 70),
            alignment: AlignmentDirectional.centerEnd,
            child: const UserInfoWidget(text: 'Public Speaking', fontSize: 24),
          ),
        ]),
        const SizedBox(height: 20),
        GestureDetector(
          child: Container(
              height: buttonHeight,
              margin: EdgeInsets.symmetric(horizontal: buttonHorizontalMargin),
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
            getVideoFile(ImageSource.gallery);
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          child: Container(
              height: buttonHeight,
              margin: EdgeInsets.symmetric(horizontal: buttonHorizontalMargin),
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
            getVideoFile(ImageSource.camera);
          },
        ),
      ]),
    );
  }
}
