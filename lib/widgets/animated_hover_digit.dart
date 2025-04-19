import 'dart:math';

import 'package:flutter/material.dart';
import 'package:macrodata_refinement/ui_theme.dart';

class AnimatedHoverDigit extends StatefulWidget {
  final int value;
  final bool isHovering;
  final bool isActive;
  final Function(bool) onHoverChange;

  const AnimatedHoverDigit({
    super.key,
    required this.value,
    required this.isHovering,
    required this.isActive,
    required this.onHoverChange,
  });

  @override
  State<AnimatedHoverDigit> createState() => _AnimatedHoverDigitState();
}

class _AnimatedHoverDigitState extends State<AnimatedHoverDigit>
    with SingleTickerProviderStateMixin {
  bool isDragging = false;
  late final AnimationController _controllerAnimation;
  late final Animation<Offset> _offsetAnimation;
  late final Axis jitterAxis;

  @override
  void initState() {
    super.initState();
    final rand = Random();
    jitterAxis = rand.nextBool() ? Axis.horizontal : Axis.vertical;

    _controllerAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500 + rand.nextInt(1500)),
    )..repeat(reverse: true);

    final double offsetAmount =
        (rand.nextDouble() * 0.01 + 0.03); // 0.03 - 0.25

    _offsetAnimation = Tween<Offset>(
      begin: Offset(
        jitterAxis == Axis.horizontal ? -offsetAmount : 0,
        jitterAxis == Axis.vertical ? -offsetAmount : 0,
      ),
      end: Offset(
        jitterAxis == Axis.horizontal ? offsetAmount : 0,
        jitterAxis == Axis.vertical ? offsetAmount : 0,
      ),
    ).animate(
      CurvedAnimation(parent: _controllerAnimation, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controllerAnimation.dispose();
    super.dispose();
  }

  Widget buildDigit(Color color, {required bool showShadows}) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Text(
        '${widget.value}',
        textAlign: TextAlign.center,
        style: UITheme.uiFont(24, color: color, glow: showShadows),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        widget.onHoverChange(true);
      },
      onExit: (_) {
        widget.onHoverChange(false);
      },

      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: widget.isHovering || widget.isActive ? 1.4 : 1.0,
        child: buildDigit(
          UITheme.themeColor,
          showShadows: widget.isHovering || widget.isActive,
        ),
      ),
    );
  }
}
