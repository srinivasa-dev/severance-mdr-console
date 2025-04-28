// widgets/bin_target.dart
import 'package:flutter/material.dart';
import '../ui_theme.dart';
import '../utils/global_scale.dart';

class BinTarget extends StatefulWidget {
  final int bin;
  final int progress;
  final void Function()? onTap;

  const BinTarget({
    super.key,
    required this.bin,
    required this.progress,
    required this.onTap,
  });

  @override
  State<BinTarget> createState() => _BinTargetState();
}

class _BinTargetState extends State<BinTarget> with TickerProviderStateMixin {
  final GlobalKey _boxKey = GlobalKey();

  late double scaleFactor;

  double _boxWidth = 180.0;

  @override
  void initState() {
    super.initState();
    scaleFactor = ScaleFactorProvider.scaleFactor;
  }

  void showAndHide() async {
    final renderBox = _boxKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final overlay = Overlay.of(_boxKey.currentContext ?? context);

    final animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, scaleFactor <= 0.8 ? -0.45 : -0.15),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder:
          (_) => Positioned(
            bottom: size.height,
            left: offset.dx,
            width: size.width,
            child: Material(
              color: Colors.transparent,
              child: SlideTransition(
                position: animation,
                child: _categoryBox(), // This is your popup widget
              ),
            ),
          ),
    );

    overlay.insert(entry);
    await animationController.forward();
    await Future.delayed(const Duration(seconds: 2));
    await animationController.reverse();
    entry.remove();
    animationController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update the scale factor when the screen size or orientation changes
    ScaleFactorProvider.updateScaleFactor(context);
    scaleFactor = ScaleFactorProvider.scaleFactor;
    _boxWidth = scaleFactor <= 0.8 ? 120.0 : scaleFactor <= 0.95 ? 130.0 : 180.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          widget.onTap != null
              ? () async {
                widget.onTap!();
                await Future.delayed(Duration(milliseconds: 600));
                showAndHide();
              }
              : () {},
      child: Column(
        key: _boxKey,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 3.0 * scaleFactor),
          Container(
            width: _boxWidth * scaleFactor,
            decoration: BoxDecoration(
              color: UITheme.backgroundColor,
              border: Border.all(
                color: UITheme.themeColor,
                width: 2.5 * scaleFactor,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '0${widget.bin}',
              style: UITheme.uiFont(
                16.0 * scaleFactor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 3.0 * scaleFactor),
          SizedBox(
            width: _boxWidth * scaleFactor,
            child: Stack(
              children: [
                Positioned.fill(
                  child: LinearProgressIndicator(
                    value: widget.progress / 100,
                    color: UITheme.themeColor,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Container(
                  width: _boxWidth * scaleFactor,
                  padding: EdgeInsets.only(left: 2.0 * scaleFactor),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: UITheme.themeColor,
                      width: 2.5 * scaleFactor,
                    ),
                  ),
                  child: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback:
                        (bounds) => LinearGradient(
                          colors: [UITheme.backgroundColor, UITheme.themeColor],
                          stops: [widget.progress / 100, widget.progress / 100],
                        ).createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                    child: Text(
                      '${widget.progress}%',
                      style: UITheme.uiFont(16.0 * scaleFactor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.0 * scaleFactor),
        ],
      ),
    );
  }

  Widget _categoryBox() {
    return Container(
      width: _boxWidth * scaleFactor,
      padding: EdgeInsets.all(3.0 * scaleFactor),
      decoration: BoxDecoration(
        color: UITheme.backgroundColor,
        border: Border.all(color: UITheme.themeColor, width: 2.5 * scaleFactor),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: UITheme.themeColor,
                width: 2.5 * scaleFactor,
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '0${widget.bin}',
                  style: UITheme.uiFont(
                    16.0 * scaleFactor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0 * scaleFactor),
          _binCategoryProgress(
            label: 'WO',
            progress: widget.progress / 100,
            color: Colors.greenAccent,
          ),
          SizedBox(height: 10.0 * scaleFactor),
          _binCategoryProgress(
            label: 'FC',
            progress: widget.progress / 100,
            color: Colors.yellow[100] ?? Colors.transparent,
          ),
          SizedBox(height: 10.0 * scaleFactor),
          _binCategoryProgress(
            label: 'DR',
            progress: widget.progress / 100,
            color: Colors.pink[100] ?? Colors.transparent,
          ),
          SizedBox(height: 10.0 * scaleFactor),
          _binCategoryProgress(
            label: 'MA',
            progress: widget.progress / 100,
            color: Colors.indigoAccent,
          ),
          SizedBox(height: 10.0 * scaleFactor),
        ],
      ),
    );
  }

  Widget _binCategoryProgress({
    required String label,
    required double progress,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 35.0 * scaleFactor,
          child: Text(
            label,
            style: UITheme.uiFont(
              16.0 * scaleFactor,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 2.0 * scaleFactor),
            ),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.transparent,
              color: color,
              minHeight: 20.0 * scaleFactor,
            ),
          ),
        ),
      ],
    );
  }
}
