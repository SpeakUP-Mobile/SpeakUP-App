import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  signOutUser() {
    FirebaseAuth.instance.signOut();
    Get.deleteAll();
  }
}
