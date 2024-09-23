import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';
import '../dashboard/dashboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final isLoggedIn = snapshot.data?.session != null;

        if (isLoggedIn) {
          return const Dashboard(); // Show home screen when logged in
        } else {
          return const LoginPage(); // Show sign-up screen when not logged in
        }
      },
    );
  }
}
