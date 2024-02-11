//
//  AccessibilityManager.swift
//  polysloth
//
//  Created by Denis Ronchese on 11/02/24.
//

import Cocoa

class AccessibilityManager {
    static let shared = AccessibilityManager()

    // ##################################
    // ####      PUBLIC METHODS      ####
    // ##################################
    func checkAccessibilityPermissions() {
        let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options as CFDictionary?)

        if !accessEnabled {
            print("Accessibility permissions are not granted.")
        } else {
            print("Accessibility permissions are granted.")
        }
    }
}
