import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_speak_cac_2024/firebase_options.dart';
import 'dashboard/dashboard_binding.dart';
// ignore: unused_import
import 'login_screen/login_page.dart';
// ignore: unused_import
import 'dashboard/dashboard.dart';
// ignore: unused_import
import 'login_screen/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PublicSpeak());
}

class PublicSpeak extends StatelessWidget {
  const PublicSpeak({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SpeakUP',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: "Poppins",
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => const AuthGate(),
            binding: DashboardBinding())
      ],
    );
  }
}
