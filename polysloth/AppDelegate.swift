//
//  AppDelegate.swift
//  polysloth
//
//  Created by Denis Ronchese on 07/02/24.
//

import Cocoa
import SwiftUI
import Quartz

extension NSEvent {
    static let escapeKeyCode: UInt16 = 53
    static let hotKeyCode: UInt16 = 49 // Spacebar
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var globalEventMonitor: Any?
    var localEventMonitor: Any?

    lazy var eventTap: CFMachPort? = {
        let eventMask = CGEventMask(1 << CGEventType.keyDown.rawValue)
        let tap = CGEvent.tapCreate(tap: .cgSessionEventTap, place: .headInsertEventTap, options: .defaultTap, eventsOfInterest: eventMask, callback: AppDelegate.eventTapCallback, userInfo: Unmanaged.passUnretained(self).toOpaque())

        if let tap = tap {
            let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
            CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
            CGEvent.tapEnable(tap: tap, enable: true)
        }

        return tap
    }()

    // Static callback function
    static let eventTapCallback: CGEventTapCallBack = { (proxy, type, event, userInfo) -> Unmanaged<CGEvent>? in
        guard type == .keyDown else { return Unmanaged.passRetained(event) }

        // Extract the AppDelegate instance from userInfo
        if let userInfo = userInfo {
            let appDelegate = Unmanaged<AppDelegate>.fromOpaque(userInfo).takeUnretainedValue()

            let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
            let flags = event.flags

            if keyCode == NSEvent.hotKeyCode && flags.contains(.maskAlternate) { // Spacebar + Option
                appDelegate.toggleWindow()
                return nil // Consume the event
            }
        }

        return Unmanaged.passRetained(event) // Pass the event unmodified for all other cases
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()
        setupWindow(with: contentView)
        setupEventMonitors()
        _ = eventTap // Initialize the event tap
        checkAccessibilityPermissions()
    }

    func checkAccessibilityPermissions() {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options as CFDictionary?)

        if !accessEnabled {
            print("Accessibility permissions are not granted.")
            // Optionally, guide the user to enable permissions in System Preferences.
        } else {
            print("Accessibility permissions are granted.")
        }
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
        window.isMovableByWindowBackground = true
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        window.level = .floating // Keep the window always on top if needed

        NotificationCenter.default.addObserver(self, selector: #selector(windowDidResignKey), name: NSWindow.didResignKeyNotification, object: window)  // Add observer to notice when the focus on the window is lost
    }

    private func setupEventMonitors() {
        setupLocalEventMonitor()
    }

    private func setupLocalEventMonitor() {
        localEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            return self?.handleLocalKeyEvent(event)
        }
    }

    private func handleLocalKeyEvent(_ event: NSEvent) -> NSEvent? {
        if event.keyCode == NSEvent.escapeKeyCode {
            NSApp.hide(nil)
            return nil
        } else if event.keyCode == NSEvent.hotKeyCode && event.modifierFlags.contains([.option]) {
            toggleWindow()
            return nil
        }
        return event
    }

    func toggleWindow() {
        if window.isVisible {
            NSApp.hide(nil) // Hide the application and return focus to the OS
        } else {
            NSApp.unhide(nil) // Restore visibility of the application
            NSApp.activate(ignoringOtherApps: true) // Acquire focus
        }
    }

    func applicationWillTerminate(_ notification: Notification) {
        if let globalEventMonitor = globalEventMonitor {
            NSEvent.removeMonitor(globalEventMonitor)
        }
        if let localEventMonitor = localEventMonitor {
            NSEvent.removeMonitor(localEventMonitor)
        }
    }

    @objc private func windowDidResignKey(notification: Notification) {
        NSApp.hide(nil) // Hide the window when it loses focus
    }

    func eventTapCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
        guard type == .keyDown else { return Unmanaged.passRetained(event) }

        let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
        let flags = event.flags

        if keyCode == NSEvent.hotKeyCode && flags.contains(.maskAlternate) { // Spacebar + Option
            toggleWindow()
            return nil // Consume the event to prevent it from propagating further
        }

        return Unmanaged.passRetained(event) // Pass the event unmodified for all other cases
    }
}
