import "dart:io";
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
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

  final testRecordings = <RecordingInfoWidget>[
    const RecordingInfoWidget(
      name: "Recording 1",
      date: 'January 1st, 2024',
      time: '18:53',
      isInterview: false,
      score: 9,
    ),
    const RecordingInfoWidget(
      name: "Recording 2",
      date: 'January 4th, 2024',
      time: '18:53',
      isInterview: true,
      score: 4,
    )
  ];

  List<RecordingInfoWidget> recordings = [];

  Future<List<String>> get _metadataPaths async {
    final localPath = await getApplicationDocumentsDirectory();
    List<String> metadataPaths = [];
    await for (var file in localPath.list(followLinks: false)) {
      if (file.path.substring(file.path.length - 8) == "metadata") {
        metadataPaths.add(file.path);
      }
    }
    return metadataPaths;
  }

  Future<List<RecordingInfoWidget>> get _recordings async {
    final paths = await _metadataPaths;
    List<RecordingInfoWidget> recordingWidgets = [];

    for (String path in paths) {
      final file = File(path);
      final contents = await file.readAsLines();
      final name = contents[0];
      final modifiedDate = await file.lastModified();
      final month = getMonth(modifiedDate.month);
      final dayEnding = getDayEnding(modifiedDate.day);
      final date = '$month ${modifiedDate.day}$dayEnding, ${modifiedDate.year}';
      final time = '${modifiedDate.hour}:${modifiedDate.minute}';
      final isInterview = contents[2] == 'interview' ? true : false;
      final score = contents[3];
      final recording = RecordingInfoWidget(
          name: name,
          date: date,
          time: time,
          isInterview: isInterview,
          score: int.parse(score));
      recordingWidgets.add(recording);
    }
    return recordingWidgets;
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Error';
    }
  }

  String getDayEnding(int day) {
    switch (day) {
      case 1 || 21 || 31:
        return 'st';
      case 2 || 22:
        return 'nd';
      case 3 || 23:
        return 'rd';
      default:
        return 'th';
    }
  }

  Future createRecordings() async {
    recordings = await _recordings;
  }

  @override
  void initState() {
    super.initState();
    createRecordings();
  }

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
