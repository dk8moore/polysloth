//
//  EventManager.swift
//  polysloth
//
//  Created by Denis Ronchese on 11/02/24.
//

import Cocoa
import Quartz

extension NSEvent {
    static let escapeKeyCode: UInt16 = 53
    static let hotKeyCode: UInt16 = 49 // Spacebar
}

class EventManager {
    static let shared = EventManager()
    
    var localEventMonitor: Any?
    // For global hotkey handling
    lazy var eventTap: CFMachPort? = {
        let eventMask = CGEventMask(1 << CGEventType.keyDown.rawValue)
        let tap = CGEvent.tapCreate(tap: .cgSessionEventTap, place: .headInsertEventTap, options: .defaultTap, eventsOfInterest: eventMask, callback: EventManager.eventTapCallback, userInfo: Unmanaged.passUnretained(self).toOpaque())

        if let tap = tap {
            let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
            CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
            CGEvent.tapEnable(tap: tap, enable: true)
        }

        return tap
    }()

    // ##################################
    // ####      PUBLIC METHODS      ####
    // ##################################
    func setupEventMonitors() {
        _ = eventTap // Initialize the event tap for global hotkeys
        setupLocalEventMonitor()
    }
    
    func stopEventMonitoring() {
        // Maybe we miss code for stopping the eventTap handler
        if let localEventMonitor = localEventMonitor {
            NSEvent.removeMonitor(localEventMonitor)
        }
    }
    
    // ###################################
    // ####      PRIVATE METHODS      ####
    // ###################################
    private func setupLocalEventMonitor() {
        localEventMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            return self?.handleLocalKeyEvent(event)
        }
    }
    
    private func handleLocalKeyEvent(_ event: NSEvent) -> NSEvent? {
        if event.keyCode == NSEvent.escapeKeyCode || (event.keyCode == NSEvent.hotKeyCode && event.modifierFlags.contains([.option])) {
            WindowManager.shared.toggleWindow()
            return nil
        }
        return event
    }
    
    // ##################################
    // ####      STATIC METHODS      ####
    // ##################################
    static let eventTapCallback: CGEventTapCallBack = { (proxy, type, event, userInfo) -> Unmanaged<CGEvent>? in
        guard type == .keyDown else { return Unmanaged.passRetained(event) }

        // Extract the AppDelegate instance from userInfo
        if let userInfo = userInfo {
            let appDelegate = Unmanaged<AppDelegate>.fromOpaque(userInfo).takeUnretainedValue()

            let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
            let flags = event.flags

            if keyCode == NSEvent.hotKeyCode && flags.contains(.maskAlternate) { // Spacebar + Option
                WindowManager.shared.toggleWindow()
                return nil // Consume the event
            }
        }

        return Unmanaged.passRetained(event) // Pass the event unmodified for all other cases
    }
}
