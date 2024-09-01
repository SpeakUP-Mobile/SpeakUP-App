import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString warningText = ''.obs;

  String? username;
  String? email;
  String? password;
  String? confirmPassword;

  Future registerNewUser(String email, String password, String username) async {
    UserCredential? userCredential;

    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        warningText.value =
            'Account with that email already exists. Please sign in instead';
      } else {
        warningText.value = e.code;
      }
      return;
    }

    if (userCredential.user != null) {
      createUserInFirestore(userCredential.user!, username);
    }
  }

  Future createUserInFirestore(User user, String username) async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(user.uid).get();

    if (!doc.exists) {
      _firestore.collection('users').doc(user.uid).set({
        'username': username,
        'email': user.email,
        'createdOn': DateTime.now(),
      });
    }
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
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email!, password: password!);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-email') {
            warningText.value = 'No user found for that email.';
          } else if (e.code == 'invalid-credential') {
            warningText.value = 'Wrong password provided for that user.';
          } else {
            warningText.value = e.code;
          }
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
