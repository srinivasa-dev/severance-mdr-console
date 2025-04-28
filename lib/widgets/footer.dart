import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macrodata_refinement/ui_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_divider.dart';

class Footer extends StatelessWidget {
  final double scaleFactor;

  Footer({super.key, required this.scaleFactor});

  Future<void> _openUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0 * scaleFactor),
      child:
          scaleFactor <= 0.8
              ? Column(
                children: [
                  _centeredText(),
                  CustomDivider(
                    height: 10.0 * scaleFactor,
                    thickness: 3.0 * scaleFactor,
                  ),
                  _flutterText(),
                  _references(),
                ],
              )
              : Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0 * scaleFactor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _flutterText(),
                    _centeredText(),
                    _references(),
                  ],
                ),
              ),
    );
  }

  Widget _centeredText() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0 * scaleFactor,
        ),
        child: Text(
          '0x15BBAA : 0xDAEAFC',
          style: UITheme.uiFont(12.0 * scaleFactor),
        ),
      ),
    );
  }

  Widget _flutterText() {
    return Text(
      'Developed using Flutter',
      style: UITheme.uiFont(14.0 * scaleFactor),
    );
  }

  Widget _references() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Image.asset(
            'assets/brand-logos/linkedin.png',
            color: UITheme.themeColor,
            height: 25.0 * scaleFactor,
            width: 25.0 * scaleFactor,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            overlayColor: UITheme.themeColor,
          ),
          onPressed: () async {
            await _openUrl(
              'https://linkedin.com/in/srinivasa-yadav',
            );
          },
        ),
        SizedBox(width: 10.0 * scaleFactor),
        IconButton(
          icon: Image.asset(
            'assets/brand-logos/github.png',
            color: UITheme.themeColor,
            height: 25.0 * scaleFactor,
            width: 25.0 * scaleFactor,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            overlayColor: UITheme.themeColor,
          ),
          onPressed: () async {
            await _openUrl(
              'https://github.com/srinivasa-dev/severance-mdr-console',
            );
          },
        ),
        if (kIsWeb)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10.0 * scaleFactor),
              ElevatedButton.icon(
                onPressed: () async {
                  await _openUrl(
                    'https://raw.githubusercontent.com/srinivasa-dev/severance-mdr-console/main/downloads/MDRConsole.exe',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: UITheme.themeColor,
                      width: 1.5 * scaleFactor,
                    ),
                  ),
                  overlayColor: UITheme.themeColor,
                ),
                icon: Image.asset(
                  'assets/brand-logos/windows.png',
                  color: UITheme.themeColor,
                  height: 20.0 * scaleFactor,
                  width: 20.0 * scaleFactor,
                ),
                label: Text(
                  'Windows',
                  style: UITheme.uiFont(14.0 * scaleFactor),
                ),
              ),
              SizedBox(width: 8.0 * scaleFactor),
              ElevatedButton.icon(
                onPressed: () async {
                  await _openUrl(
                    'https://raw.githubusercontent.com/srinivasa-dev/severance-mdr-console/main/downloads/MDRConsole.dmg',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(
                      color: UITheme.themeColor,
                      width: 1.5 * scaleFactor,
                    ),
                  ),
                  overlayColor: UITheme.themeColor,
                ),
                icon: Image.asset(
                  'assets/brand-logos/apple.png',
                  color: UITheme.themeColor,
                  height: 20.0 * scaleFactor,
                  width: 20.0 * scaleFactor,
                ),
                label: Text(
                  'macOS',
                  style: UITheme.uiFont(14.0 * scaleFactor),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
