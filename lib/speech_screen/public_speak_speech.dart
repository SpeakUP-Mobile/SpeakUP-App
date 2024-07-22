import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../custom_global_widgets/user_info_widget.dart';

class PublicSpeakSpeech extends StatefulWidget {
  const PublicSpeakSpeech({super.key});

  @override
  State<PublicSpeakSpeech> createState() => _PublicSpeakSpeechState();
}

class _PublicSpeakSpeechState extends State<PublicSpeakSpeech> {
  getVideoFile(ImageSource sourceImage) async {
    final videoFile = await ImagePicker().pickVideo(source: sourceImage);

    if (videoFile != null) {
      print("Hello World");
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
            getVideoFile(ImageSource.gallery);
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
            getVideoFile(ImageSource.camera);
          },
        ),
      ]),
    );
  }
}
