import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  registerPrompt() {
    Get.dialog(registerDialog());
  }

  registerDialog() {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          height: 100,
          child: Column(
            children: [
              Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.cancel_rounded))),
              const Text('Register', style: TextStyle(fontSize: 32.0)),
              const SizedBox(height: 25),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      Container(
                          height: 45,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE8E8E8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, bottom: 15),
                          child: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Color(0xFFBFBFBF))),
                          )),
                      const SizedBox(height: 10),
                      Container(
                          height: 45,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE8E8E8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, bottom: 15),
                          child: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email adress',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Color(0xFFBFBFBF))),
                          )),
                      const SizedBox(height: 10),
                      Container(
                          height: 45,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE8E8E8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, bottom: 15),
                          child: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Color(0xFFBFBFBF))),
                          )),
                      const SizedBox(height: 10),
                      Container(
                          height: 45,
                          decoration: const BoxDecoration(
                              color: Color(0xFFE8E8E8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, bottom: 15),
                          child: const TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm your password',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Color(0xFFBFBFBF))),
                          )),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text('By continuing, you agree to SpeakUP\'s',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Privacy Policy',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlueAccent)),
                            Text(' and ',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                            Text('Terms and Conditions',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlueAccent)),
                          ],
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future registerNewUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // handle error
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
}
