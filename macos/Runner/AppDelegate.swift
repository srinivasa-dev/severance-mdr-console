import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    var splashWindow: NSWindow?
    
  override func applicationDidFinishLaunching(_ notification: Notification) {
    // Set the custom cursor here
    setCustomCursor(imageName: "mdr-cursor.png")

      // 1. Create Splash Window
        showSplashScreen()

        // 2. Delay for splash duration (e.g., 2 seconds), then load Flutter
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          self.splashWindow?.close()
          self.splashWindow = nil
        }

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

 private func showSplashScreen() {
 guard let screen = NSScreen.main else { return }
  let screenFrame = screen.visibleFrame
     
 // Create window
  let window = NSWindow(
    contentRect: screenFrame,
    styleMask: .borderless,
    backing: .buffered,
    defer: false
  )

  window.center()
  window.isReleasedWhenClosed = false
  window.backgroundColor = NSColor(red: 0.0, green: 0.078, blue: 0.157, alpha: 1.0) // #001428
  window.level = .floating
     
     // Image view setup
        if let image = NSImage(named: "lumon-logo.png") {
          image.isTemplate = true // Enables tinting
          let imageView = NSImageView(image: image)
          imageView.frame.size = NSSize(width: 150, height: 150)
          imageView.contentTintColor = NSColor(calibratedRed: 0.556, green: 0.89, blue: 0.945, alpha: 1.0) // #8EE3F1
          imageView.imageScaling = .scaleProportionallyUpOrDown

          // Center the image
          imageView.translatesAutoresizingMaskIntoConstraints = false
          let contentView = NSView()
          contentView.addSubview(imageView)

          NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
          ])

          window.contentView = contentView
        }

        window.makeKeyAndOrderFront(nil)
        self.splashWindow = window
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
