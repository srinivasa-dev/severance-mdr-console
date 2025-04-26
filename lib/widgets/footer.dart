import 'package:flutter/material.dart';
import 'package:macrodata_refinement/ui_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _openUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Developed using Flutter', style: UITheme.uiFont(14.0)),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('0x15BBAA : 0xDAEAFC', style: UITheme.uiFont(12)),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/brand-logos/linkedin.png',
                  color: UITheme.themeColor,
                  height: 25.0,
                  width: 25.0,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  overlayColor: UITheme.themeColor,
                ),
                onPressed: () async {
                  await _openUrl('https://linkedin.com/in/srinivasa-yadav');
                },
              ),
              SizedBox(width: 10.0),
              IconButton(
                icon: Image.asset(
                  'assets/brand-logos/github.png',
                  color: UITheme.themeColor,
                  height: 25.0,
                  width: 25.0,
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
              SizedBox(width: 10.0),
              ElevatedButton.icon(
                onPressed: () async {
                  await _openUrl('');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: UITheme.themeColor, width: 1.5),
                  ),
                  overlayColor: UITheme.themeColor,
                ),
                icon: Image.asset(
                  'assets/brand-logos/windows.png',
                  color: UITheme.themeColor,
                  height: 20.0,
                  width: 20.0,
                ),
                label: Text('Windows', style: UITheme.uiFont(14.0)),
              ),
              SizedBox(width: 8.0),
              ElevatedButton.icon(
                onPressed: () async {
                  await _openUrl(
                    'https://github.com/srinivasa-dev/severance-mdr-console/blob/main/downloads/MDRConsole.dmg',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: UITheme.themeColor, width: 1.5),
                  ),
                  overlayColor: UITheme.themeColor,
                ),
                icon: Image.asset(
                  'assets/brand-logos/apple.png',
                  color: UITheme.themeColor,
                  height: 20.0,
                  width: 20.0,
                ),
                label: Text('macOS', style: UITheme.uiFont(14.0)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
