import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speakup/dashboard/dashboard_binding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_screen/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://omotzypqzerrcymfovba.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9tb3R6eXBxemVycmN5bWZvdmJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjUxMzY5NjIsImV4cCI6MjA0MDcxMjk2Mn0.Q8e_Q0h-P3FADJk6Izalu-n8-eQ0HGEBBIxLDEH9ur0',
  );
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
            page: () => const AuthGate(),
            binding: DashboardBinding())
      ],
    );
  }
}
