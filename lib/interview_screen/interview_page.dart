import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class InterviewPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const InterviewPage({super.key, required this.cameras});

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  late CameraController _cameraController;
  late Future<void> cameraValue;

  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;

  @override
  void initState() {
    _cameraController =
        CameraController(widget.cameras[1], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            leading: InkWell(
                onTap: () => Get.back(), child: const Icon(Icons.arrow_back))),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: GradientText(
                'Interview',
                colors: const [Color(0xff8710D0), Color(0xffFF18BE)],
                style: const TextStyle(fontSize: 48),
              ),
            ),
            Container(
                height: screenWidth,
                width: screenWidth,
                decoration: const BoxDecoration(color: Colors.grey),
                child: FutureBuilder(
                    future: cameraValue,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ClipRect(
                            child: OverflowBox(
                                alignment: Alignment.center,
                                child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: SizedBox(
                                        width: screenWidth,
                                        height: screenWidth *
                                            _cameraController.value.aspectRatio,
                                        child: CameraPreview(
                                            _cameraController)))));
                      } else {
                        return const Text('Loading Camera Preview...');
                      }
                    })),
          ],
        ));
  }
}
