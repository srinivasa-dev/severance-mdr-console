import 'package:flutter/widgets.dart';

class ScaleFactorProvider {
  static double _scaleFactor = 1.0;

  static double get scaleFactor => _scaleFactor;

  // Method to update scale factor based on screen width
  static void updateScaleFactor(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 320) {
      _scaleFactor = 0.45;
    } else if (screenWidth < 360) {
      _scaleFactor = 0.5;
    } else if (screenWidth < 400) {
      _scaleFactor = 0.6;
    } else if (screenWidth < 480) {
      _scaleFactor = 0.7;
    } else if (screenWidth < 540) {
      _scaleFactor = 0.75;
    } else if (screenWidth < 600) {
      _scaleFactor = 0.8;
    } else if (screenWidth < 680) {
      _scaleFactor = 0.85;
    } else if (screenWidth < 760) {
      _scaleFactor = 0.9;
    } else if (screenWidth < 840) {
      _scaleFactor = 0.95;
    } else {
      _scaleFactor = 1.0;
    }
  }

  // Method to scale a value based on the scale factor
  static double scaleValue(double value) {
    return value * _scaleFactor;
  }
}
