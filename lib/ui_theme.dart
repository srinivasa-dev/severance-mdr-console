import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UITheme {
  static const Color backgroundColor = Color(0xFF001428);
  static const Color themeColor = Color(0xFF8EE3F1);

  static TextStyle uiFont(
      double size, {
        double opacity = 1,
        bool glow = false,
        FontWeight fontWeight = FontWeight.normal,
        Color? color,
      }) {
    return GoogleFonts.ibmPlexMono(
      fontSize: size,
      color: (color ?? themeColor).withOpacity(opacity),
      fontWeight: fontWeight,
      shadows: glow
          ? [
        const Shadow(
          blurRadius: 10,
          color: Colors.cyan,
          offset: Offset(0, 0),
        ),
      ]
          : null,
    );
  }
}