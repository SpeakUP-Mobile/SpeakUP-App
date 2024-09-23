import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  signOutUser() {
    Supabase.instance.client.auth.signOut();
    Get.deleteAll();
  }
}
