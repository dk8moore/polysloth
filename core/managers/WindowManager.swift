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
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.borderless],
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
    }
    
    func toggleWindow() {
        if window.isVisible {
            NSApp.hide(nil) // Hide the application and return focus to the OS
        } else {
            NSApp.unhide(nil) // Restore visibility of the application
            NSApp.activate(ignoringOtherApps: true) // Acquire focus
        }
    }
    
    
    // ###################################
    // ####      PRIVATE METHODS      ####
    // ###################################
    @objc private func windowDidResignKey(notification: Notification) {
        NSApp.hide(nil)
    }
}
