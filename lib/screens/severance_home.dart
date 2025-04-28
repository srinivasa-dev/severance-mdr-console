import 'dart:math';
import 'package:flutter/material.dart';
import 'package:macrodata_refinement/widgets/custom_alert_dialogs.dart';
import 'package:macrodata_refinement/widgets/custom_divider.dart';
import 'package:macrodata_refinement/widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui_theme.dart';
import '../utils/global_scale.dart';
import '../widgets/animated_hover_digit.dart';
import '../widgets/bin_target.dart';

class SeveranceHomePage extends StatefulWidget {
  const SeveranceHomePage({super.key});

  @override
  State<SeveranceHomePage> createState() => _SeveranceHomePageState();
}

class _SeveranceHomePageState extends State<SeveranceHomePage> {
  int _crossAxisCount = 20;
  List<List<int>> grid = [];

  final Map<int, int> binProgress = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

  int get totalProgress =>
      binProgress.values.fold(0, (a, b) => a + b) ~/ binProgress.length;

  int? hoveredRow;
  int? hoveredCol;

  // Use a set to track the active indices
  Set<int> activeIndices = Set<int>();

  List<GlobalKey> _binKeys = List.generate(5, (j) => GlobalKey());
  Map<int, GlobalKey> gridKeys = {};

  late double scaleFactor;

  @override
  void initState() {
    grid = List.generate(
      _crossAxisCount,
      (_) => List.generate(_crossAxisCount, (_) => Random().nextInt(10)),
    );

    for (int i = 0; i < 400; i++) {
      gridKeys[i] = GlobalKey();
    }
    scaleFactor = ScaleFactorProvider.scaleFactor;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update the scale factor when the screen size or orientation changes
    ScaleFactorProvider.updateScaleFactor(context);
    scaleFactor = ScaleFactorProvider.scaleFactor;
    _crossAxisCount = scaleFactor <= 0.8 ? 10 : 20;
    grid = List.generate(
      _crossAxisCount,
      (_) => List.generate(_crossAxisCount, (_) => Random().nextInt(10)),
    );
  }

  void _addAnimatedDigitOverlay(Offset start, Offset end, int value) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) {
        return TweenAnimationBuilder<Offset>(
          tween: Tween(begin: start, end: end),
          duration: const Duration(milliseconds: 500),
          builder: (_, offset, child) {
            return Positioned(left: offset.dx, top: offset.dy, child: child!);
          },
          child: Material(
            color: Colors.transparent,
            child: AnimatedHoverDigit(
              value: value,
              isHovering: false,
              isActive: true,
              onHoverChange: (value) {},
            ),
          ),
        );
      },
    );

    overlay.insert(entry);
    Future.delayed(const Duration(milliseconds: 700), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UITheme.backgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                right: 25.0 * scaleFactor,
                top: 0,
                bottom: 0,
                child: Transform.scale(
                  scale: 0.6 * scaleFactor,
                  child: Image.asset(
                    'assets/lumon-logo.png',
                    color: UITheme.themeColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 18.0 * scaleFactor,
                  horizontal: 60.0 * scaleFactor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 6.0 * scaleFactor),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: UITheme.themeColor,
                    width: 2.0 * scaleFactor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse('https://srinivasa.dev');
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Text(
                        'Nivasael',
                        style: UITheme.uiFont(
                          20.0 * scaleFactor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 100.0 * scaleFactor),
                      child: Text(
                        '$totalProgress% Complete',
                        style: UITheme.uiFont(
                          20.0 * scaleFactor,
                          color: Colors.transparent,
                          fontWeight: FontWeight.w600,
                        ).copyWith(
                          foreground:
                              Paint()
                                ..strokeWidth = 1
                                ..color = UITheme.themeColor
                                ..style = PaintingStyle.stroke,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomDivider(),
          CustomDivider(height: 10.0 * scaleFactor),
          Expanded(
            child: GridView.builder(
              itemCount: grid.length * grid[0].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                mainAxisSpacing: 4 * scaleFactor,
                crossAxisSpacing: 4 * scaleFactor,
                childAspectRatio: 0.8 * scaleFactor,
              ),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                int row = index ~/ _crossAxisCount;
                int col = index % _crossAxisCount;
                int val = grid[row][col];

                bool isHovered = false;

                if (hoveredRow != null && hoveredCol != null) {
                  int dRow = (row - hoveredRow!).abs();
                  int dCol = (col - hoveredCol!).abs();
                  if (dRow <= 1 && dCol <= 1) {
                    isHovered = true;
                  }
                }

                return GestureDetector(
                  onTap: () {
                    // Mark the entire region as active when tapped
                    setState(() {
                      hoveredRow = row;
                      hoveredCol = col;

                      for (int r = hoveredRow! - 1; r <= hoveredRow! + 1; r++) {
                        for (
                          int c = hoveredCol! - 1;
                          c <= hoveredCol! + 1;
                          c++
                        ) {
                          if (r >= 0 &&
                              r < _crossAxisCount &&
                              c >= 0 &&
                              c < _crossAxisCount) {
                            int activeIndex = r * _crossAxisCount + c;
                            activeIndices.add(
                              activeIndex,
                            ); // Add the index to the active set
                          }
                        }
                      }
                    });
                  },
                  child: Container(
                    key: gridKeys[row * _crossAxisCount + col],
                    child: AnimatedHoverDigit(
                      value: val,
                      isHovering: isHovered,
                      isActive: activeIndices.contains(
                        row * _crossAxisCount + col,
                      ),
                      onHoverChange: (hovering) {
                        setState(() {
                          if (hovering) {
                            hoveredRow = row;
                            hoveredCol = col;
                          } else {
                            hoveredRow = null;
                            hoveredCol = null;
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          CustomDivider(),
          CustomDivider(height: 6.0 * scaleFactor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (i) {
              final bin = i + 1;
              return BinTarget(
                key: _binKeys[i],
                bin: bin,
                progress: binProgress[bin]!,
                onTap:
                    activeIndices.isNotEmpty
                        ? () async {
                          for (int index in activeIndices) {
                            final gridKey = gridKeys[index];
                            final renderBox =
                                gridKey?.currentContext?.findRenderObject()
                                    as RenderBox?;
                            final binRenderBox =
                                _binKeys[i].currentContext?.findRenderObject()
                                    as RenderBox?;

                            if (renderBox != null && binRenderBox != null) {
                              final start = renderBox.localToGlobal(
                                Offset.zero,
                              );
                              final end = binRenderBox.localToGlobal(
                                Offset.zero,
                              );

                              _addAnimatedDigitOverlay(
                                start,
                                end,
                                grid[index ~/ _crossAxisCount][index %
                                    _crossAxisCount],
                              );
                            }
                          }

                          setState(() {
                            binProgress[bin] = (binProgress[bin]! + 5).clamp(
                              0,
                              100,
                            );
                          });
                          // Trigger animation (e.g., moving selected items)
                          await Future.delayed(Duration(milliseconds: 300), () {
                            setState(() {
                              // Move the active indices out of view
                              activeIndices
                                  .clear(); // Optionally, clear after animation
                              hoveredRow = null;
                              hoveredCol = null;
                            });
                          });

                          await Future.delayed(Duration(seconds: 3));

                          if (totalProgress == 100) {
                            await CustomAlertDialogs().showCentPercentDialog(
                              context,
                            );
                            setState(() {
                              binProgress.updateAll((key, value) => 0);
                            });
                          }
                        }
                        : null,
              );
            }),
          ),
          CustomDivider(
            height: 4.0 * scaleFactor,
            thickness: 2.0 * scaleFactor,
          ),
          Footer(scaleFactor: scaleFactor),
          SizedBox(height: 5.0 * scaleFactor),
        ],
      ),
    );
  }
}
