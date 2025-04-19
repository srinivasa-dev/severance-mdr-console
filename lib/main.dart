import 'package:flutter/material.dart';
import 'screens/severance_home.dart';

void main() {
  runApp(const SeveranceApp());
}

class SeveranceApp extends StatelessWidget {
  const SeveranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SeveranceHomePage(),
    );
  }
}