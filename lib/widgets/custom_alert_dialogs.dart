import 'package:flutter/material.dart';
import 'package:macrodata_refinement/ui_theme.dart';

class CustomAlertDialogs {
  Future<void> showCentPercentDialog(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      pageBuilder: (context, animation, secondaryAnimation) {
        return SizedBox.shrink();
      },
      transitionBuilder: (cont, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: UITheme.themeColor, width: 2.0),
              ),
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              alignment: Alignment.center,
              backgroundColor: UITheme.backgroundColor,
              content: Container(
                width: 600.0,
                constraints: BoxConstraints(minWidth: 200.0, maxWidth: 600.0),
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.symmetric(vertical: 60.0),
                decoration: BoxDecoration(
                  border: Border.all(color: UITheme.themeColor, width: 2.0),
                ),
                child: BlinkingText(),
              ),
            ),
          ),
        );
      }, // Control animation speed
    );

    await Future.delayed(Duration(seconds: 4));

    // Check if the context is still mounted before performing any action
    if (context.mounted) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }
}

class BlinkingText extends StatefulWidget {
  const BlinkingText({super.key});

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(
      reverse: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Text(
        '100%',
        style: UITheme.uiFont(60.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
