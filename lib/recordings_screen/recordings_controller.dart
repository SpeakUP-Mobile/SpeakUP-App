import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../interview_screen/interview_results.dart';
import 'recording_info_widget.dart';

class RecordingsController extends GetxController {
  RxString username = ''.obs;
  RxInt view = 0.obs;
  RxList<RecordingInfoWidget> recordings = <RecordingInfoWidget>[].obs;

  @override
  void onInit() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    username.value = currentUser!.userMetadata!['username'];
    updateRecordings();
    super.onInit();
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

    for (int i = 0; i < paths.length; i++) {
      var path = paths[i];
      final info = await getInfoFromMetadata(path);
      //print('$info');
      final uid = info[0];
      final name = info[1];
      final date = info[2];
      final time = info[3];
      final isInterview = info[4];
      final videoPaths = info[5];
      final score = info[6];
      final thumbnailPath = info[7];
      final questions = info[8];
      final questionScores = info[9];
      final llamaResults = info[10];
      final recording = RecordingInfoWidget(
        name: name,
        date: date,
        time: time,
        isInterview: isInterview,
        videoPaths: videoPaths,
        score: score,
        thumbnailPath: thumbnailPath,
        questions: questions,
        questionResults: questionScores,
        llamaResults: llamaResults,
      );
      if (uid == Supabase.instance.client.auth.currentUser!.id) {
        recordingWidgets.add(recording);
      }
    }
    return recordingWidgets;
  }

  Future<List<dynamic>> getInfoFromMetadata(String path) async {
    final file = File(path);
    final contents = await file.readAsLines();
    final uid = contents[0].trim();
    final name = contents[1].trim();
    final modifiedDate = await file.lastModified();
    final month = getMonth(modifiedDate.month);
    final dayEnding = getDayEnding(modifiedDate.day);
    final date = '$month ${modifiedDate.day}$dayEnding, ${modifiedDate.year}';
    final time = '${modifiedDate.hour}:${modifiedDate.minute}';
    final isInterview = contents[2] == 'interview' ? true : false;
    final numberOfFiles = int.parse(contents[3].trim());
    List<String> videoPaths = [];
    for (int i = 0; i < numberOfFiles; i++) {
      videoPaths.add(contents[4 + i]);
    }

    for (var i = 0; i < contents.length; i++) {
      print(contents[i]);
    }

    final score = int.parse(contents[4 + int.parse(contents[3].trim())].trim());
    final thumbnailPath = contents[5 + int.parse(contents[3].trim())].trim();
    List<String> questions = [];
    List<List<int>> scores = [];
    List<String> llamaResults = [];

    if (isInterview) {
      for (int i = 0; i < numberOfFiles; i++) {
        String question = contents[i + 6 + 2 * numberOfFiles].trim();
        questions.add(question);
        /*
        final temp = contents[3 +
                numberOfFiles +
                2 +
                numberOfFiles +
                numberOfFiles +
                3 * i +
                1]
            .trim();
        print(temp);
        print(int.parse(temp));
      */
        int positiveScore = int.parse(contents[3 +
                numberOfFiles +
                2 +
                numberOfFiles +
                numberOfFiles +
                3 * i +
                1]
            .trim());
        int negativeScore = int.parse(contents[3 +
                numberOfFiles +
                2 +
                numberOfFiles +
                numberOfFiles +
                3 * i +
                2]
            .trim());
        int fillerScore = int.parse(contents[3 +
                numberOfFiles +
                2 +
                numberOfFiles +
                numberOfFiles +
                3 * i +
                3]
            .trim());
        List<int> questionScores = [positiveScore, negativeScore, fillerScore];
        scores.add(questionScores);
        String llamaResult = contents[contents.length - numberOfFiles + i];
        //print('Print ${llamaResult}');
        llamaResults.add(llamaResult);
      }
    }

    return [
      uid,
      name,
      date,
      time,
      isInterview,
      videoPaths,
      score,
      thumbnailPath,
      questions,
      scores,
      llamaResults,
    ];
  }

  void clearMetadata() async {
    List<String> paths = await _metadataPaths;
    for (int i = 0; i < paths.length; i++) {
      await File(paths[i]).delete();
    }
    await updateRecordings();
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

  deleteRecording(
      String name, List<String> videoPaths, String thumbnailPath) async {
    for (int i = 0; i < videoPaths.length; i++) {
      await File(videoPaths[i]).delete();
    }
    final localPath = await getApplicationDocumentsDirectory();
    await File('${localPath.path}/$name.metadata').delete();
    //await File(thumbnailPath).delete();
    updateRecordings();
  }

  viewRecording(
      bool isInterview,
      String name,
      String date,
      String time,
      int score,
      List<String> videoPaths,
      List<String> questions,
      List<List<int>> questionResults,
      List<String> llamaResults) async {
    if (isInterview) {
      Get.to(const InterviewResults(), arguments: [
        name,
        date,
        time,
        score,
        videoPaths,
        questions,
        questionResults,
        llamaResults
      ]);
    } else {
      //print('No speeches yet');
    }
  }
}
