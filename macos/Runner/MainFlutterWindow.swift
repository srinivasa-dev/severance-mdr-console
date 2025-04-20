import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    // Get full screen size dynamically
      if let screen = NSScreen.main {
        let screenFrame = screen.visibleFrame // avoids overlapping the dock
        self.setFrame(screenFrame, display: true)
      }

    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
