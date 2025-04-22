import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macrodata_refinement/splash_screen.dart';
import 'screens/severance_home.dart';

void main() {
  runApp(const SeveranceApp());
}

class SeveranceApp extends StatelessWidget {
  const SeveranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: kIsWeb ? SeveranceHomePage() : Platform.isWindows ? SplashScreen() : SeveranceHomePage(),
    );
  }
}
