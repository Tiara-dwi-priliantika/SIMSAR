import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const SimSarApp());
}

class SimSarApp extends StatelessWidget {
  const SimSarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIMSAR',

      // Menggunakan tema SIMSAR
      theme: AppTheme.lightTheme,

      // Halaman pertama yang dibuka
      home: const LoginScreen(),
    );
  }
}