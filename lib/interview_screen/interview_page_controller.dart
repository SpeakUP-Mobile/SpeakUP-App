import 'dart:async';
import 'package:camera/camera.dart' hide ImageFormat;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import '../recordings_screen/recordings_controller.dart';
import 'interview_results.dart';
import 'package:video_compress/video_compress.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'interview_questions.dart';
import 'dart:math' as math;

Future<String?> analyzeUrl(String videoUrl) async {
  final url = Uri.parse(
      'https://omotzypqzerrcymfovba.supabase.co/functions/v1/analyze-url'); // The URL of the Supabase function [CHANGE WHEN TESTING]

  var requestBody = jsonEncode({'videoUrl': videoUrl});

  try {
    // Send the POST request (translation from the curl command)
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
  return null;
}

class InterviewPageController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  RxBool isPreviewLoading = true.obs;

  RxBool isProcessingFiles = false.obs;
  RxString processingState = ''.obs;
  RxInt totalProcessingSteps = 1.obs;
  RxInt currentProcessingStep = 0.obs;

  late List<String> questions;
  RxInt currentQuestion = 0.obs;
  int numQuestions = 3;

  RxBool isRecording = false.obs;
  RxBool isDoneRecording = false.obs;

  RxInt recordingSeconds = 0.obs;
  bool endTimer = false;
  RxList<int> questionTimes = <int>[].obs;

  RxBool isCameraFront = true.obs;

  List<String> videoPaths = [];

  String interviewName = 'UNTITLED 1';

  bool isAnalysisDone = false;

  //NOTE: SET THIS TO TRUE WHEN TESTING WITH LLAMA OUTPUT AND FALSE WHEN ONLY TESTING HUME JSON OUTPUT
  //ALSO CHANGE IN THE INITIALIZE VARIABLES FUNCTION
  bool getLlamaOutput = false;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  void onInit() async {
    super.onInit();
    initializeVariables();
    await getPermissions();
    await initalizeCamera();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  Future<void> initalizeCamera() async {
    chooseQuestions();
    cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.low);
    await cameraController.initialize();
    isPreviewLoading.value = false;
    isProcessingFiles.value = false;
    processingState.value = '';
    totalProcessingSteps.value = 1;
    currentProcessingStep.value = 0;
  }

  void chooseQuestions() {
    final allQuestions = InterviewQuestions.getQuestions();
    //print(allQuestions.length);
    final random = math.Random();
    List<int> randomList = [];
    while (randomList.length < numQuestions) {
      int num = random.nextInt(allQuestions.length);
      //print(num);
      if (!randomList.contains(num)) {
        //print("adding ");
        randomList.add(num);
      }
      //print("Running");
    }
    questions = randomList.map((int i) => allQuestions[i]).toList();
    //print(questions);
  }

  Future<void> getPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
  }

  void initializeVariables() {
    chooseQuestions();
    currentQuestion.value = 0;
    isPreviewLoading.value = true;
    isCameraFront.value = true;
    questionTimes.value =
        List<int>.filled(questions.length, 0, growable: false);
    interviewName = 'Interview 1';
  }

  Future<void> pressRecord() async {
    if (!isPreviewLoading.value) {
      if (!isRecording.value && !isDoneRecording.value) {
        isPreviewLoading.value = true;
        await cameraController.startVideoRecording();
        isPreviewLoading.value = false;
        Timer.periodic(const Duration(seconds: 1), (Timer t) => timer(t));
        isRecording.value = true;
      } else if (isRecording.value) {
        final videoPath = (await cameraController.stopVideoRecording()).path;
        print(videoPath);
        videoPaths.insert(currentQuestion.value, videoPath);
        endTimer = true;
      }
    }
  }

  void timer(Timer t) {
    if (endTimer) {
      t.cancel();
      endTimer = false;
      questionTimes[currentQuestion.value] = recordingSeconds.value;
      recordingSeconds.value = 0;
      isRecording.value = false;
      isDoneRecording.value = true;
    } else {
      recordingSeconds.value++;
    }
  }

  void retakeRecording() async {
    await File(videoPaths[currentQuestion.value]).delete();
    videoPaths.removeAt(currentQuestion.value);
    questionTimes[currentQuestion.value] = 0;
    isDoneRecording.value = false;
    Get.back();
  }

  void flipCamera() async {
    if (cameras.length > 1 && !isRecording.value) {
      cameraController = CameraController(
          cameras[isCameraFront.value ? 0 : 1], ResolutionPreset.high);
      isPreviewLoading.value = true;
      await cameraController.initialize();
      isPreviewLoading.value = false;
      isCameraFront.value = !isCameraFront.value;
    }
  }

  void previousQuestion() {
    if (currentQuestion.value != 0) {
      currentQuestion--;
      isDoneRecording.value = true;
    }
  }

  void nextQuestion() {
    if (isDoneRecording.value) {
      if (currentQuestion.value != questions.length - 1) {
        currentQuestion++;
        isDoneRecording.value = videoPaths.length > currentQuestion.value;
      }
    }
  }

  void exitInterview() async {
    for (String path in videoPaths) {
      await File(path).delete();
    }
    Get.back();
    Get.back();
    Get.back();
  }

  Future<void> endInterview() async {
    Get.back();
    final supabase = Supabase.instance.client;
    isProcessingFiles.value = true;
    List<String> compressedFiles = [];
    List<String> compressedUrls = [];
    List<String> jobIds = [];
    totalProcessingSteps.value = videoPaths.length * 5 + 2;
    cameraController.dispose();

    if (getLlamaOutput) {
      totalProcessingSteps.value++;
    }

    for (int i = 0; i < videoPaths.length; i++) {
      processingState.value = 'Compressing Files ${i + 1}/${videoPaths.length}';
      MediaInfo? compressedFile =
          await VideoCompress.compressVideo(videoPaths[i]);
      compressedFiles.add(compressedFile!.path!);
      currentProcessingStep.value++;
    }

    for (int i = 0; i < videoPaths.length; i++) {
      processingState.value = 'Uploading Files ${i + 1}/${videoPaths.length}';
      await supabase.storage.from('users').upload(
          '${Supabase.instance.client.auth.currentUser!.id}/recordings/$interviewName/$i.mp4',
          File(compressedFiles[i]));
      final String publicUrl = supabase.storage.from('users').getPublicUrl(
          '${Supabase.instance.client.auth.currentUser!.id}/recordings/$interviewName/$i.mp4');
      compressedUrls.add(publicUrl);
      currentProcessingStep.value++;
    }

    for (int i = 0; i < videoPaths.length; i++) {
      processingState.value =
          'Deleting Compressed Files ${i + 1}/${videoPaths.length}';
      await File(compressedFiles[i]).delete();
      currentProcessingStep.value++;
    }

    for (int i = 0; i < videoPaths.length; i++) {
      processingState.value = 'Starting Analysis ${i + 1}/${videoPaths.length}';

      //THESE LINES ARE FOR TESTING WITH NISH'S PC (COMMENT WHEN TESTING REMOTELY)
      //final res = await analyzeUrl(compressedUrls[i]);
      //final response = json.decode(res!);
      //jobIds.add(response['data']['job_id']);
      //await Future.delayed(const Duration(seconds: 15));

      //THESE LINES ARE FOR TESTING USING SUPABSE HOSTING (COMMENT WHEN TESTING LOCALLY)
      final response = await supabase.functions
          .invoke('analyze-url', body: {'videoUrl': compressedUrls[i]});
      jobIds.add(response.data['data']['job_id']);
      currentProcessingStep.value++;
    }

    processingState.value =
        'Waiting for Analysis Results... (This may take a while)';
    isAnalysisDone = false;
    Timer.periodic(const Duration(seconds: 1),
        (Timer t) => awaitAnalysisResults(t, jobIds, supabase));
  }

  void awaitAnalysisResults(
      Timer t, List<String> jobIds, SupabaseClient supabase) async {
    final List<FileObject> objects = await supabase.storage
        .from('users')
        .list(path: '${supabase.auth.currentUser!.id}/analyzed-json');
    int matchCount = 0;
    for (int i = 0; i < jobIds.length; i++) {
      for (int j = 0; j < objects.length; j++) {
        if (jobIds[i] ==
            objects[j].name.substring(0, objects[j].name.length - 5)) {
          matchCount++;
          break;
        }
      }
    }

    if (matchCount == jobIds.length) {
      t.cancel();
      if (getLlamaOutput) {
        processingState.value =
            'Summarizing Results... (This may take a while)';
        currentProcessingStep.value++;
        Timer.periodic(const Duration(seconds: 1),
            (Timer t) => fetchLlamaResults(t, jobIds, supabase));
      } else {
        await finishAnalysis(jobIds, supabase);
      }
    }
  }

  Future<void> fetchLlamaResults(
      Timer t, List<String> jobIds, SupabaseClient supabase) async {
    final List<FileObject> objects = await supabase.storage
        .from('users')
        .list(path: '${supabase.auth.currentUser!.id}/llama-output');
    int matchCount = 0;
    for (int i = 0; i < jobIds.length; i++) {
      for (int j = 0; j < objects.length; j++) {
        if (jobIds[i] ==
            objects[j].name.substring(0, objects[j].name.length - 4)) {
          matchCount++;
          break;
        }
      }

      if (matchCount == jobIds.length) {
        t.cancel();
        await finishAnalysis(jobIds, supabase);
      }
    }
  }

  Future<void> finishAnalysis(
      List<String> jobIds, SupabaseClient supabase) async {
    currentProcessingStep.value++;

    for (int i = 0; i < videoPaths.length; i++) {
      processingState.value =
          'Deleting Cloud Files ${i + 1}/${videoPaths.length}';
      // await supabase.storage.from('users').remove([
      //   '${Supabase.instance.client.auth.currentUser!.id}/recordings/$interviewName/$i.mp4'
      // ]);
      currentProcessingStep.value++;
    }

    processingState.value = 'Creating Metadata';
    final path = await createMetadata(jobIds, supabase);
    currentProcessingStep.value++;

    for (int i = 0; i < jobIds.length; i++) {
      await supabase.storage.from('avatars').remove(
          ['${supabase.auth.currentUser!.id}/analyzed-json/${jobIds[i]}.json']);
    }

    final interviewInfo =
        await Get.find<RecordingsController>().getInfoFromMetadata(path);
    final date = interviewInfo[2];
    final time = interviewInfo[3];
    final score = interviewInfo[6];
    final questionResults = interviewInfo[9];
    final llamaResults = interviewInfo[10];
    Get.find<RecordingsController>().updateRecordings();
    Get.to(const InterviewResults(), arguments: [
      interviewName,
      date,
      time,
      score,
      videoPaths,
      questions,
      questionResults,
      llamaResults
    ]);
  }

  Future<String> createMetadata(
      List<String> jobIds, SupabaseClient supabase) async {
    final path = await _localPath;
    final file = File('$path/$interviewName.metadata');
    final thumbnailPath = await getThumbnailPath(videoPaths[0]);
    final jsonResults = await parseJson(jobIds);
    await file.writeAsString(
        '${Supabase.instance.client.auth.currentUser!.id}\n',
        mode: FileMode.append); //User ID
    await file.writeAsString('$interviewName\n',
        mode: FileMode.append); //Interview name
    await file.writeAsString('interview\n', mode: FileMode.append); //Interview
    await file.writeAsString('${videoPaths.length}\n',
        mode: FileMode.append); //Number of files
    for (int i = 0; i < videoPaths.length; i++) {
      await file.writeAsString('${videoPaths[i]}\n',
          mode: FileMode.append); //Paths of video
    }
    int rating = calculateOverallScore(jsonResults);
    await file.writeAsString('$rating\n',
        mode: FileMode.append); //Rating out of 100
    await file.writeAsString('$thumbnailPath\n',
        mode: FileMode.append); //Path of thumbnail file
    for (int i = 0; i < videoPaths.length; i++) {
      await file.writeAsString('${jobIds[i]}\n', mode: FileMode.append);
    } //Job IDs
    for (int i = 0; i < videoPaths.length; i++) {
      await file.writeAsString('${questions[i]}\n', mode: FileMode.append);
    } //Interview Questions

    for (int i = 0; i < videoPaths.length; i++) {
      for (int j = 0; j < 3; j++) {
        await file.writeAsString('${jsonResults[i][j]}\n',
            mode: FileMode.append);
      } //Scores for positive, negative, and filler words
    }
    List<String>? llamaOutputs;
    if (getLlamaOutput) {
      llamaOutputs = await llamaOutput(jobIds, supabase);
    }
    for (int i = 0; i < videoPaths.length; i++) {
      //print('interview_page_controller.fart, ln 415 ${llamaOutputs![i]}');
      if (getLlamaOutput) {
        await file.writeAsString('${llamaOutputs![i]}\n',
            mode: FileMode.append);
      } else {
        await file.writeAsString(
            'This is an example overview paragraph. In the actual app, we will use Llama in order to generate a short summary of the user\'s emotions during each question\n',
            mode: FileMode.append);
      }
    } //Llama
    return file.path;
  }

  Future<List<String>> llamaOutput(
      List<String> jobIds, SupabaseClient supabase) async {
    List<String> llamaOutputs = [];
    for (int i = 0; i < jobIds.length; i++) {
      var file = await supabase.storage.from('users').download(
          '${supabase.auth.currentUser!.id}/llama-output/${jobIds[i]}.txt');
      var llamaOutput = ascii.decode(file);
      llamaOutputs.add(llamaOutput);
    }

    return llamaOutputs;
  }

  int calculateOverallScore(List<List<int>> jsonResults) {
    double overallScore = 0;
    List<int> questionScores = [];
    for (int i = 0; i < jsonResults.length; i++) {
      double questionScore = (jsonResults[i][0] * 0.6) +
          ((100 - jsonResults[i][1]) * 0.2) +
          ((100 - jsonResults[i][2]) * 0.2);
      questionScore = questionScore / 2;
      questionScore += 50;
      questionScores.add(questionScore.round());
    }

    for (int i = 0; i < questionScores.length; i++) {
      //print(questionScores[i]);
      overallScore += questionScores[i];
    }

    overallScore /= questionScores.length;

    return overallScore.round();
  }

  Future<List<List<int>>> parseJson(List<String> jobIds) async {
    final supabase = Supabase.instance.client;
    List<List<int>> results = [];
    for (int i = 0; i < jobIds.length; i++) {
      List<int> questionResults = [];
      final file = await supabase.storage.from('users').download(
          '${supabase.auth.currentUser!.id}/analyzed-json/${jobIds[i]}.json');
      final jsonData = json.decode(ascii.decode(file));

      final models =
          jsonData['predictions'][0]['results']['predictions'][0]['models'];
      final faceData = models['face']['grouped_predictions'][0]['predictions'];

      const numPositiveEmotions = 11;
      const numNegativeEmotions = 13;
      List<double> framePositiveScores = [];
      List<double> frameNegativeScores = [];

      for (int j = 0; j < faceData.length; j++) {
        final emotions = faceData[j]['emotions'];
        double framePositiveSum = 0;
        double frameNegativeSum = 0;
        for (int k = 0; k < emotions.length; k++) {
          if (isPositiveEmotion(emotions[k]['name'])) {
            framePositiveSum += emotions[k]['score'];
          } else if (isNegativeEmotion(emotions[k]['name'])) {
            frameNegativeSum += emotions[k]['score'];
          }
        }
        framePositiveScores.add(framePositiveSum / numPositiveEmotions);
        frameNegativeScores.add(frameNegativeSum / numNegativeEmotions);
      }

      double totalPositiveSum = 0;
      double totalNegativeSum = 0;
      for (int j = 0; j < faceData.length; j++) {
        totalPositiveSum += framePositiveScores[j];
        totalNegativeSum += frameNegativeScores[j];
      }

      final totalPositiveScore =
          ((totalPositiveSum / faceData.length) * 100).round();
      final totalNegativeScore =
          ((totalNegativeSum / faceData.length) * 100).round();

      int fillerWordScore = 0;

      if (models['prosody'] != null) {
        String transcription = '';
        final prosodyData =
            models['prosody']['grouped_predictions'][0]['predictions'];
        for (int i = 0; i < prosodyData.length; i++) {
          transcription += prosodyData[i]['text'] + ' ';
        }
        int wordCount = transcription.split(' ').length;
        int fillerWordCount = 0;

        final burstData = models['burst']['grouped_predictions'];
        fillerWordCount += int.parse(burstData.length);

        fillerWordScore = (100 /
                (1 +
                    math.pow(math.e,
                        (-1 * ((-30 * (fillerWordCount / wordCount)) - 5)))))
            .round();
      }

      questionResults.add(totalPositiveScore);
      questionResults.add(totalNegativeScore);
      questionResults.add(fillerWordScore); //Placeholder for filler word score
      results.add(questionResults);
    }
    return results;
  }

  //Positive: Calmness, Concentration, Contemplation, Contentment, Determination, Excitement, Interest, Joy, Realization, Surprise (positive), Triumph
  //Negative: Anger, Anxiety, Awkwardness, Boredom, Confusion, Contempt, Distress, Doubt, Embarrassment, Fear, Pride, Surprise (negative), Tiredness

  bool isPositiveEmotion(String emotion) {
    return emotion == 'Calmness' ||
        emotion == 'Concentration' ||
        emotion == 'Contemplation' ||
        emotion == 'Contentment' ||
        emotion == 'Determination' ||
        emotion == 'Excitement' ||
        emotion == 'Interest' ||
        emotion == 'Joy' ||
        emotion == 'Realization' ||
        emotion == 'Surprise (positive)' ||
        emotion == 'Triumph';
  }

  bool isNegativeEmotion(String emotion) {
    return emotion == 'Anger' ||
        emotion == 'Anxiety' ||
        emotion == 'Awkwardness' ||
        emotion == 'Boredom' ||
        emotion == 'Confusion' ||
        emotion == 'Contempt' ||
        emotion == 'Distress' ||
        emotion == 'Doubt' ||
        emotion == 'Embarrassment' ||
        emotion == 'Fear' ||
        emotion == 'Pride' ||
        emotion == 'Surprise (negative)' ||
        emotion == 'Tiredness';
  }

  Future<String> getThumbnailPath(String videoPath) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: ImageFormat.PNG,
      maxHeight: 100,
      quality: 500,
    );
    print('Path: $fileName');
    return fileName!;
  }

  void updateName(String name) {
    interviewName = name;
  }
}
