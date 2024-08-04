import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard/dashboard_binding.dart';
import 'dashboard/dashboard.dart';
import 'login_screen/login_page.dart';

void main() {
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
            page: () => const LoginPage(),
            binding: DashboardBinding())
      ],
    );
  }
}
