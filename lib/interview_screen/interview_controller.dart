import 'package:camera/camera.dart';
import 'package:get/get.dart';

class InterviewController extends GetxController {
  Future<List<CameraDescription>> getCameras() async {
    return await availableCameras();
  }
}
