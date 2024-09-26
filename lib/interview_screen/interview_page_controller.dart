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

Future<void> analyzeUrl(String videoUrl) async {
  final url = Uri.parse(
      'https://8ab5-76-205-203-7.ngrok-free.app/functions/v1/analyze-url'); // The URL of the Supabase function [CHANGE WHEN TESTING]

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
      print('Response data: ${response.body}');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
  }
}

// TODO: close the camera as iOS shows it in use even when out of an interview

class InterviewPageController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  RxBool isPreviewLoading = true.obs;

  RxBool isProcessingFiles = false.obs;
  RxString processingState = ''.obs;
  RxInt totalProcessingSteps = 1.obs;
  RxInt currentProcessingStep = 0.obs;

  List<String> questions = [
    'Talk about a time where you demonstrated leadership qualities.',
    'What is you ideal work environment?',
    'Why did you decide to apply for a position at this company?'
  ];
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

  Future<void> initalizeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[1], ResolutionPreset.low);
    await cameraController.initialize();
    isPreviewLoading.value = false;
    isProcessingFiles.value = false;
    processingState.value = '';
    totalProcessingSteps.value = 1;
    currentProcessingStep.value = 0;
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
      /*
      processingState.value =
          'Deleting Compressed Files ${i + 1}/${videoPaths.length}';
      await File(compressedFiles[i]).delete();
      */
      currentProcessingStep.value++;
    }

    for (int i = 0; i < videoPaths.length; i++) {
      processingState.value = 'Starting Analysis ${i + 1}/${videoPaths.length}';
      print('Analyzing ${compressedUrls[i]}');
      analyzeUrl(compressedUrls[i]);
      //TODO: Store job id in jobIds list
      jobIds.add('$i');
      currentProcessingStep.value++;
    }

    processingState.value = 'Waiting for Results (This may take a while)';
    //TODO: Check supabase storage every 100 ms and proceed when all jobIds are present
    currentProcessingStep.value++;

    for (int i = 0; i < videoPaths.length; i++) {
      processingState.value =
          'Deleting Cloud Files ${i + 1}/${videoPaths.length}';
      await supabase.storage.from('users').remove([
        '${Supabase.instance.client.auth.currentUser!.id}/recordings/$interviewName/$i.mp4'
      ]);
      currentProcessingStep.value++;
    }

    processingState.value = 'Creating Metadata';
    final path = await createMetadata(jobIds);
    currentProcessingStep.value++;
    final interviewInfo =
        await Get.find<RecordingsController>().getInfoFromMetadata(path);
    final date = interviewInfo[2];
    final time = interviewInfo[3];
    final score = interviewInfo[6];
    Get.find<RecordingsController>().updateRecordings();
    Get.to(const InterviewResults(),
        arguments: [interviewName, date, time, score, videoPaths, questions]);
  }

  Future<String> createMetadata(List<String> jobIds) async {
    final path = await _localPath;
    final file = File('$path/$interviewName.metadata');
    final thumbnailPath = await getThumbnailPath(videoPaths[0]);

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
    await file.writeAsString('96\n', mode: FileMode.append); //Rating out of 100
    await file.writeAsString('$thumbnailPath\n',
        mode: FileMode.append); //Path of thumbnail file
    for (int i = 0; i < videoPaths.length; i++) {
      await file.writeAsString('${jobIds[i]}\n', mode: FileMode.append);
    } //Job IDs
    for (int i = 0; i < videoPaths.length; i++) {
      await file.writeAsString('${questions[i]}\n', mode: FileMode.append);
    }

    return file.path;
  }

  Future<String> getThumbnailPath(String videoPath) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 100,
      quality: 500,
    );
    return fileName!;
  }

  void updateName(String name) {
    interviewName = name;
  }
}
