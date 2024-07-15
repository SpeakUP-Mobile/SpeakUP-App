import "package:flutter/material.dart";
import "package:public_speak_cac_2024/common_widgets.dart";
import "package:public_speak_cac_2024/custom_global_widgets/user_info_widget.dart";
import "package:public_speak_cac_2024/recordings_screen/recording_info_widget.dart";

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
          margin: const EdgeInsets.only(bottom: 5),
          child: const UserInfoWidget(text: 'Your Past Recordings'),
        ),
      ]),
      filterButtons(),
      const RecordingInfoWidget(
        recordingNumber: 1,
        date: 'January 1st, 2024',
        time: '18:53',
        isInterview: false,
        score: 9,
      )
    ]));
  }

  Container filterButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(children: [
        Container(
            height: 30,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(
                color: Color(0xFFFFB5C2),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                ]),
            child: const Text("Public Speech")),
        Container(
            height: 30,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
                color: Color(0xFFB5DBFF),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                ]),
            child: const Text('Interview')),
      ]),
    );
  }
}
