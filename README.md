![MDR-Console Gif](https://github.com/srinivasa-dev/severance-mdr-console/blob/main/doc/mdr-console.GIF)

# Severance MDR Console

A Flutter-based cross-platform console UI inspired by the **Severance** series, designed to simulate Macro Data Refinement (MDR) operations in a dark, minimal, corporate-styled environment.

---

## 🧠 Overview

The Severance MDR Console is a fictional productivity console built using Flutter, targeting desktop (Windows, macOS) and web. It allows users to engage with dynamic data bins, animated numeric inputs, and a stylized user experience that mirrors the eerie but structured world of Severance.

This is a UI/UX concept app for creative exploration and experimentation.

---

## 📥 Download Links

| Platform    | Download Link                                                                                                               |
|-------------|-----------------------------------------------------------------------------------------------------------------------------|
| **Web**     | [Open in Browser](https://mdrconsole.srinivasa.dev/)                                                                        |
| **Windows** | [Download Windows App](https://raw.githubusercontent.com/srinivasa-dev/severance-mdr-console/main/downloads/MDRConsole.exe) |
| **macOS**   | [Download macOS App](https://raw.githubusercontent.com/srinivasa-dev/severance-mdr-console/main/downloads/MDRConsole.dmg)   |

---

## 🚀 Features

- 🗂️ **Bin Target System** – Visual UI to display and interact with MDR bin categories.
- 🔢 **Animated Hover Digits** – Custom numbers with jitter-style hover animation.
- 🌘 **Themed UI** – Full dark theme with monospace fonts and minimalist styling.
- 🖼️ **Splash Screen** – Brand-focused splash screen at launch.
- 🧩 **Modular Widgets** – Designed for maintainability and scalability.
- 🖥️ **Platform-aware UI** – Adapts based on whether the app is running on desktop or web.
- 🖱️ **Custom Cursors** – Unique, custom-designed cursors for both Web and macOS platforms, enhancing the overall aesthetic and user experience.

---

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **Styling**: Google Fonts (`ibmPlexMono`), Custom Themes
- **Animations**: Implicit and explicit Flutter animations
- **Architecture**: Widget-based, component modularity

---

## 📁 Project Structure
```bash
lib/
├── main.dart                  # App entry point and platform handling
├── ui_theme.dart              # Global styles, fonts, and colors
├── splash_screen.dart         # Initial splash screen widget
├── screens/
│   └── severance_home.dart    # Main home screen containing MDR interface
└── widgets/
├── bin_target.dart            # Widget for displaying and interacting with 
                                 bin targets
├── animated_hover_digit.dart  # Animated numeric display on hover
├── custom_divider.dart        # Custom divider with styling
├── utils/
    └── global_scale.dart      # Contains the ScaleFactorProvider class for 
                                 screen size adjustments
```

### 🔍 File Details

- **main.dart**  
  Detects the platform (web, desktop, etc.) and routes to the proper screen.

- **ui_theme.dart**  
  Applies the custom dark theme using `ThemeData`, Google Fonts, and monochrome color palette.

- **splash_screen.dart**  
  The splash animation and branding shown during app startup.

- **screens/severance_home.dart**  
  The primary interface where MDR interactions happen. Hosts all UI components and interactions.

- **widgets/bin_target.dart**  
  Displays individual bin containers with animated states and interactions.

- **widgets/animated_hover_digit.dart**  
  A number component that reacts to mouse hover with a slight positional jitter and opacity shift.

- **widgets/custom_divider.dart**  
  A stylized divider line widget used for separating UI sections.

- **utils/global_scale.dart**  
  This file contains the `ScaleFactorProvider` class, which calculates and applies a scale factor based on the device’s screen width.
  It helps ensure that the UI remains proportionate and readable across different screen sizes by dynamically adjusting the size of UI elements.

---

### 🖱️ Custom Cursor Implementation

#### Web (index.html)

For the Web version of the Severance MDR Console, a custom cursor is applied using the following CSS in index.html:
```css
html, body {
  cursor: url("./assets/mdr-cursor.png") 16 16, auto;
}
```

This ensures that when users interact with the page, they experience the custom cursor styled for the application.

#### macOS

On macOS, a custom cursor is set using a Flutter macOS plugin written in Swift. The custom cursor changes whenever the mouse moves over the application window, giving the interface a unified and engaging look. The following Swift code is used in AppDelegate.swift:

```swift
import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationDidFinishLaunching(_ notification: Notification) {
    // Set the custom cursor here
    setCustomCursor(imageName: "mdr-cursor.png")
    return super.applicationDidFinishLaunching(notification)
  }

  func setCustomCursor(imageName: String) {
    if let fullPath = Bundle.main.path(forResource: imageName, ofType: nil),
       let image = NSImage(contentsOfFile: fullPath) {

      let cursor = NSCursor(image: image, hotSpot: NSPoint(x: image.size.width / 2, y: image.size.height / 2))
      cursor.set()

      // Optionally re-apply the cursor on movement
      NSEvent.addLocalMonitorForEvents(matching: .mouseMoved) { event in
        cursor.set()
        return event
      }

      NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved) { _ in
        cursor.set()
      }

    } else {
      print("Cursor image not found: \(imageName)")
    }
  }
}
```

This code ensures that the custom cursor is set when the app launches on macOS, providing a seamless user experience similar to the Web version.

---

## ⚙️ Scale Factor Adjustment

To ensure the app's UI adapts across different screen sizes, the `ScaleFactorProvider` class provides dynamic scaling of UI elements based on the device's screen width. This allows for a consistent user experience on various devices, from small screens to larger displays.

### How it Works

1. **Scale Factor Calculation**  
   The `updateScaleFactor` method takes the current screen width and assigns an appropriate scale factor:
  - Smaller screens have a reduced scale factor.
  - Larger screens use a scale factor closer to `1.0` (no scaling).

   This method helps ensure that the UI remains usable and well-proportioned on all devices.

2. **Scaling Values**  
   The `scaleValue` method multiplies the provided value by the current scale factor, ensuring that dimensions and spacing are adjusted accordingly.

Example usage in the app:
```dart
ScaleFactorProvider.updateScaleFactor(context);
double scaledValue = ScaleFactorProvider.scaleValue(originalValue);
```

---

## ▶️ Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart (included with Flutter)
- Git

### Run the Project

```bash
git clone https://github.com/srinivasa-dev/severance-mdr-console.git
cd severance-mdr-console
flutter pub get
flutter run -d windows   # or chrome, macos.
```

---

## 🧪 Status

This is a work-in-progress prototype. It focuses on creativity, UI exploration, and immersive design rather than production use.

---

## 🤝 Contributions

Feel free to fork, play, and adapt this UI for your own creative or experimental needs.  
Open to feedback, feature requests, and wild ideas!

---

## 📄 License

MIT License. Attribution is appreciated if you use the concept in your own work.

---

## 👤 Author

**Srinivasa Yadav**  
🌐 [Portfolio](https://srinivasa.dev)  
💼 [LinkedIn](https://www.linkedin.com/in/srinivasa-yadav)

---