import "package:flutter/material.dart";
import "package:public_speak_cac_2024/custom_global_widgets/user_info_widget.dart";
import "package:public_speak_cac_2024/recordings_screen/recording_info_widget.dart";

class PublicSpeakRecordings extends StatefulWidget {
  const PublicSpeakRecordings({super.key});

  @override
  State<PublicSpeakRecordings> createState() => _PublicSpeakRecordingsState();
}

class _PublicSpeakRecordingsState extends State<PublicSpeakRecordings> {
  String userName = "TESTING NAME";
  int view = 0;

  final recordings = <RecordingInfoWidget>[
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Stack(children: [
        Container(
          padding: const EdgeInsets.only(top: 70),
          alignment: AlignmentDirectional.topCenter,
          margin: const EdgeInsets.only(bottom: 15),
          child: UserInfoWidget(
            text: 'Good Morning,',
            fontSize: 24,
            name: userName,
            showName: true,
          ),
        ),
      ]),
      filterButtons(),
      Column(children: [
        for (RecordingInfoWidget recording in recordings)
          if (view == 0)
            recording
          else if (view == 1 && !recording.isInterview)
            recording
          else if (view == 2 && recording.isInterview)
            recording
      ])
    ]));
  }

  Container filterButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Container(
            height: 35,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
                color: view == 0
                    ? Colors.white
                    : const Color.fromARGB(255, 222, 222, 222),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                ]),
            child: InkWell(
              onTap: () {
                setState(() {
                  view = 0;
                });
              },
              child: const Text(
                "All",
                style: TextStyle(color: Colors.black),
              ),
            )),
        Container(
            height: 35,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                gradient: view == 1
                    ? const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 176, 60, 248),
                          Color(0xffFF18BE)
                        ],
                      )
                    : const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 130, 44, 184),
                          Color.fromARGB(255, 178, 17, 133)
                        ],
                      ),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
                ]),
            child: InkWell(
              onTap: () {
                setState(() {
                  view = 1;
                });
              },
              child: Text(
                "Public Speech",
                style: TextStyle(
                    color: view == 1
                        ? Colors.white
                        : const Color.fromARGB(255, 199, 199, 199)),
              ),
            )),
        Container(
          height: 35,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              gradient: view == 2
                  ? const LinearGradient(
                      colors: [Color(0xFF4F23FF), Color(0xFF8F00FF)])
                  : const LinearGradient(colors: [
                      Color.fromARGB(255, 57, 26, 181),
                      Color.fromARGB(255, 92, 0, 163)
                    ]),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              boxShadow: const [
                BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 2.5),
              ]),
          child: InkWell(
            onTap: () {
              setState(() {
                view = 2;
              });
            },
            child: Text('Interview',
                style: TextStyle(
                    color: view == 2
                        ? Colors.white
                        : const Color.fromARGB(255, 199, 199, 199))),
          ),
        ),
      ]),
    );
  }
}
