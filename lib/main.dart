import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/dashboard/dashboard.dart';
import 'package:speakup/dashboard/dashboard_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SpeakUP());
}

class SpeakUP extends StatelessWidget {
  const SpeakUP({super.key});

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
            page: () => const Dashboard(),
            binding: DashboardBinding())
      ],
    );
  }
}
