//
//  AppDelegate.swift
//  polysloth
//
//  Created by Denis Ronchese on 07/02/24.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the custom window and set the content view.
        window = RoundedWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.borderless],
            backing: .buffered, defer: false)
        window.isMovableByWindowBackground = true
        window.center()
        window.setIsVisible(true)
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        window.level = .floating // Keep the window always on top if needed
    }

    // Rest of the AppDelegate code...
}
