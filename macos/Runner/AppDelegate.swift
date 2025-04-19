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

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
