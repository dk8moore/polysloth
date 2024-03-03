//
//  WindowManager.swift
//  polysloth
//
//  Created by Denis Ronchese on 11/02/24.
//

import Cocoa
import SwiftUI

class WindowManager {
    static let shared = WindowManager()
    
    var window: NSWindow!
    
    // ##################################
    // ####      PUBLIC METHODS      ####
    // ##################################
    func setupMainWindow() {
        let contentView = ContentView()
        window = RoundedWindow(
            contentRect: NSRect(x: 0, y: 0, width: GlobalConstants.Window.windowWidth, height: GlobalConstants.Window.headerHeight + GlobalConstants.Window.footerHeight),
            styleMask: [.borderless, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.setIsVisible(true)
        window.isMovableByWindowBackground = true
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        window.level = .floating    // Keep the window always on top if needed

        NotificationCenter.default.addObserver(self, selector: #selector(windowDidResignKey), name: NSWindow.didResignKeyNotification, object: window) // Add observer to notice when the focus on the window is lost
        // Listen to changes in the desired height of the content
        // This is a conceptual step - you'll need to implement a mechanism to determine the desired size based on your content
        NotificationCenter.default.addObserver(forName: NSNotification.Name("AdjustWindowSize"), object: nil, queue: nil) { notification in
            if let size = notification.userInfo?["size"] as? CGSize {
                self.adjustWindowSize(size: size)
            }
        }
    }
    
    func toggleWindow() {
        if window.isVisible {
            NSApp.hide(nil) // Hide the application and return focus to the OS
        } else {
            NSApp.unhide(nil) // Restore visibility of the application
            NSApp.activate(ignoringOtherApps: true) // Acquire focus
        }
    }
    
    func adjustWindowSize(size: CGSize) {
        var frame = window.frame
        let contentSize = window.contentRect(forFrameRect: frame)
        let deltaHeight = size.height - contentSize.height
        let deltaWidth = size.width - contentSize.width
        frame.size.height += deltaHeight
        frame.size.width += deltaWidth
        frame.origin.y -= deltaHeight // Adjust the origin so the window grows upwards
        
        window.setFrame(frame, display: true, animate: true)
    }
    
    
    // ###################################
    // ####      PRIVATE METHODS      ####
    // ###################################
    @objc private func windowDidResignKey(notification: Notification) {
        NSApp.hide(nil)
    }
}
