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
      body: SafeArea(
        bottom: false,
        child: Column(children: [
          const SizedBox(height: 10),
          Center(
            child: GradientText(
              'Interview',
              colors: const [Color(0xff8710D0), Color(0xffFF18BE)],
              style: const TextStyle(fontSize: 58, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          cameraPreview(screenWidth),
          const Spacer(),
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(children: [
                const SizedBox(height: 35),
                SizedBox(
                  width: screenWidth * 0.85,
                  child: const Text(
                      'Talk about a time where you demonstrated leadership skills',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18)),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    InkWell(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 48,
                        )),
                    const Spacer(flex: 3),
                    InkWell(
                        onTap: () {},
                        child: const Icon(Icons.radio_button_checked,
                            color: Colors.red, size: 48)),
                    const Spacer(flex: 3),
                    InkWell(
                        onTap: () {},
                        child: const Icon(Icons.arrow_forward, size: 48)),
                    const Spacer()
                  ],
                ),
                const Spacer(),
              ]))
        ]),
      ),
    );
  }

  Container cameraPreview(double screenWidth) {
    return Container(
        height: screenWidth,
        width: screenWidth,
        decoration: const BoxDecoration(color: Colors.grey),
        child: ClipRect(
            child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: FutureBuilder(
                        future: cameraValue,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return SizedBox(
                                width: screenWidth,
                                height: screenWidth *
                                    _cameraController.value.aspectRatio,
                                child: CameraPreview(_cameraController));
                          } else {
                            return const Padding(
                                padding: EdgeInsets.all(20),
                                child: CircularProgressIndicator());
                          }
                        })))));
  }
}
