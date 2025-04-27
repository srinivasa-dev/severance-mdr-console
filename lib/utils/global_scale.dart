import 'package:flutter/widgets.dart';

class ScaleFactorProvider {
  static double _scaleFactor = 1.0;

  static double get scaleFactor => _scaleFactor;

  // Method to update scale factor based on screen width
  static void updateScaleFactor(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 400) {
      _scaleFactor = 0.5;
    } else if (screenWidth < 600) {
      _scaleFactor = 0.7;
    } else if (screenWidth < 700) {
      _scaleFactor = 0.85;
    } else {
      _scaleFactor = 1.0;
    }
  }

  // Method to scale a value based on the scale factor
  static double scaleValue(double value) {
    return value * _scaleFactor;
  }
}
