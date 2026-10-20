import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'screens/splash_screen.dart';

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
      home: const SplashScreen(),
    );
  }
}