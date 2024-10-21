import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  RxString warningText = ''.obs;

  String? username;
  String? email;
  String? password;
  String? confirmPassword;

  Future registerNewUser(String email, String password, String username) async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username},
    );
    await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  registerUser() {
    if (username != null) {
      if (email != null) {
        if (password != null) {
          if (!password!.contains(' ')) {
            if (password == confirmPassword) {
              Get.back();
              registerNewUser(
                  email!.trim(), password!.trim(), username!.trim());
            } else {
              warningText.value = 'Passwords do not match';
            }
          } else {
            warningText.value = 'Password cannot contain a space';
          }
        } else {
          warningText.value = 'Please enter a password';
        }
      } else {
        warningText.value = 'Please enter an email address';
      }
    } else {
      warningText.value = 'Please enter your name';
    }
  }

  loginUser() async {
    if (email != null) {
      if (password != null) {
        try {
          final supabase = Supabase.instance.client;
          await supabase.auth.signInWithPassword(
            email: email!.trim(),
            password: password!,
          );
        } catch (e) {
          warningText.value = 'Error';
          return;
        }
        Get.back();
      } else {
        warningText.value = 'Please enter a password';
      }
    } else {
      warningText.value = 'Please enter an email';
    }
  }

  resetWarningText() {
    warningText.value = '';
  }

  updateUsername(String username) {
    this.username = username;
  }

  updateEmail(String email) {
    this.email = email;
  }

  updatePassword(String password) {
    this.password = password;
  }

  updateConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
  }
}
