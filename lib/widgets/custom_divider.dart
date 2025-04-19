import 'package:flutter/material.dart';
import 'package:macrodata_refinement/ui_theme.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double thickness;

  const CustomDivider({super.key, this.height = 0, this.thickness = 3.5});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: UITheme.themeColor,
    );
  }
}
