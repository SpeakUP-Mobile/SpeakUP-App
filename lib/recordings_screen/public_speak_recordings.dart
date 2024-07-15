import "package:flutter/material.dart";
import "package:public_speak_cac_2024/common_widgets.dart";
import "package:public_speak_cac_2024/custom_widgets/user_info_widget.dart";

class PublicSpeakRecordings extends StatefulWidget {
  const PublicSpeakRecordings({super.key});

  @override
  State<PublicSpeakRecordings> createState() => _PublicSpeakRecordingsState();
}

class _PublicSpeakRecordingsState extends State<PublicSpeakRecordings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Stack(children: [
        CommonWidgets.topBanner(),
        Container(
          padding: const EdgeInsets.only(left: 20, top: 70, right: 20),
          alignment: AlignmentDirectional.topCenter,
          margin: const EdgeInsets.only(bottom: 13),
          child: const UserInfoWidget(text: 'Your Past Recordings'),
        ),
      ])
    ]));
  }
}
