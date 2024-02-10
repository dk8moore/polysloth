//
//  AppDelegate.swift
//  polysloth
//
//  Created by Denis Ronchese on 07/02/24.
//

import Cocoa
import SwiftUI

extension NSEvent {
    static let escapeKeyCode: UInt16 = 53
    static let hotkeyCharacter: String = "<"
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var globalEventMonitor: Any?
    var localEventMonitor: Any?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()
        setupWindow(with: contentView)
        setupEventMonitors()
    }

    private func setupWindow(with contentView: ContentView) {
        window = RoundedWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.setIsVisible(true)
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        window.level = .floating // Keep the window always on top if needed
    }

    private func setupEventMonitors() {
        setupGlobalEventMonitor()
        setupLocalEventMonitor()
    }

    private func setupGlobalEventMonitor() {
        globalEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleGlobalKeyEvent(event)
        }
    }

    private func setupLocalEventMonitor() {
        localEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            return self?.handleLocalKeyEvent(event)
        }
    }

    private func handleGlobalKeyEvent(_ event: NSEvent) {
        guard let characters = event.characters, characters == NSEvent.hotkeyCharacter else { return }
        if event.modifierFlags.contains([.command, .shift]) {
            DispatchQueue.main.async { [weak self] in
                self?.toggleWindow()
            }
        }
    }

    private func handleLocalKeyEvent(_ event: NSEvent) -> NSEvent? {
        if event.keyCode == NSEvent.escapeKeyCode {
            hideAndReturnFocus()
            return nil
        } else if let characters = event.characters, characters == NSEvent.hotkeyCharacter,
                  event.modifierFlags.contains([.command, .shift]) {
            toggleWindow()
            return nil
        }
        return event
    }

    private func toggleWindow() {
        if window.isVisible {
            hideAndReturnFocus()
        } else {
            showAndFocusWindow()
        }
    }

    private func showAndFocusWindow() {
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    private func hideAndReturnFocus() {
        window.orderOut(nil)
        NSApp.deactivate()
    }

    func applicationWillTerminate(_ notification: Notification) {
        if let globalEventMonitor = globalEventMonitor {
            NSEvent.removeMonitor(globalEventMonitor)
        }
        if let localEventMonitor = localEventMonitor {
            NSEvent.removeMonitor(localEventMonitor)
        }
    }
}
