import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../speech_screen/speech_analysis.dart';
import 'recording_info_widget.dart';

class RecordingsController extends GetxController {
  RxString username = ''.obs;
  RxInt view = 0.obs;
  RxList<RecordingInfoWidget> recordings = <RecordingInfoWidget>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // run on new login as well

  @override
  void onInit() async {
    await getUsername();
    updateRecordings();
    super.onInit();
  }

  getUsername() async {
    final doc =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    username.value = doc.data()!['username'];
  }

  String getTime() {
    final hour = DateTime.now().hour;
    String text = '';
    if (hour >= 5 && hour < 12) {
      text = 'Morning';
    } else if (hour >= 12 && hour < 20) {
      text = 'Afternoon';
    } else if (hour >= 20 && hour < 23) {
      text = 'Evening';
    } else {
      text = 'Night';
    }
    return text;
  }

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
      final thumbnailPath = contents[4];
      final recording = RecordingInfoWidget(
        name: name,
        date: date,
        time: time,
        isInterview: isInterview,
        score: int.parse(score),
        thumbnailPath: thumbnailPath,
      );
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

  Future updateRecordings() async {
    recordings.value = await _recordings;
    recordings.refresh();
  }

  setView(value) {
    view.value = value;
  }

  deleteRecording(String name) async {
    final localPath = await getApplicationDocumentsDirectory();
    final file = File('${localPath.path}/$name.metadata');
    final contents = await file.readAsLines();
    final videoPath = contents[1];
    final video = File(videoPath);
    await video.delete();
    await file.delete();
    updateRecordings();
  }

  viewRecording(String name) async {
    final localPath = await getApplicationDocumentsDirectory();
    final metadataFile = File('${localPath.path}/$name.metadata');
    final contents = await metadataFile.readAsLines();
    final videoPath = contents[1];
    Get.to(SpeechAnalysisPage(recordingName: name, videoPath: videoPath));
  }
}
