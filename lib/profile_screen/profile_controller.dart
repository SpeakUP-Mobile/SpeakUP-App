import 'package:get/get.dart';

class ProfileController extends GetxController {
  signOutUser() {
    // add sign out func
    Get.deleteAll();
  }
}
