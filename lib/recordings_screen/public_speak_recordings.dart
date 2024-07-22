import "package:flutter/material.dart";
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
        Container(
          padding: const EdgeInsets.only(top: 70),
          alignment: AlignmentDirectional.topCenter,
          margin: const EdgeInsets.only(bottom: 5),
          child: const UserInfoWidget(
            text: 'Good Morning,',
            fontSize: 24,
            name: "Name",
            showName: true,
          ),
        ),
      ]),
      filterButtons(),
      const RecordingInfoWidget(
        recordingNumber: 1,
        date: 'January 1st, 2024',
        time: '18:53',
        isInterview: false,
        score: 9,
      ),
      const RecordingInfoWidget(
        recordingNumber: 2,
        date: 'January 4th, 2024',
        time: '18:53',
        isInterview: true,
        score: 4,
      )
    ]));
  }

  Container filterButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 15),
      child: Row(children: [
        Container(
            height: 30,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 176, 60, 248),
                    Color(0xffFF18BE)
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                ]),
            child: const Text(
              "Public Speech",
              style: TextStyle(color: Colors.white),
            )),
        Container(
            height: 30,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF4F23FF), Color(0xFF8F00FF)]),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                ]),
            child: const Text(
              'Interview',
              style: TextStyle(color: Colors.white),
            )),
      ]),
    );
  }
}
