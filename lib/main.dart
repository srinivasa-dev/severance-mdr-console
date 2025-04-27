import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macrodata_refinement/splash_screen.dart';
import 'package:macrodata_refinement/utils/global_scale.dart';
import 'screens/severance_home.dart';

void main() {
  runApp(const SeveranceApp());
}

class SeveranceApp extends StatelessWidget {
  const SeveranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Update scale factor when the app starts
    ScaleFactorProvider.updateScaleFactor(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          kIsWeb
              ? SeveranceHomePage()
              : Platform.isWindows
              ? SplashScreen()
              : SeveranceHomePage(),
    );
  }
}
