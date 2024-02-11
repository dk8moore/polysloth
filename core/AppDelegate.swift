//
//  AppDelegate.swift
//  polysloth
//
//  Created by Denis Ronchese on 11/02/24.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        WindowManager.shared.setupMainWindow()
        EventManager.shared.setupEventMonitors()
        AccessibilityManager.shared.checkAccessibilityPermissions()
    }

    func applicationWillTerminate(_ notification: Notification) {
        EventManager.shared.stopEventMonitoring()
    }
}
