//
//  RoundedWindows.swift
//  polysloth
//
//  Created by Denis Ronchese on 07/02/24.
//

import AppKit

class RoundedWindow: NSWindow {
    private var effectView: NSVisualEffectView!
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless], backing: backingStoreType, defer: flag)
        self.isOpaque = false
        self.backgroundColor = NSColor.clear
        self.hasShadow = true
        // Customize the shape and appearance of the window
        setupRoundedCorners()
    }
    
    override var canBecomeKey: Bool {
        return true
    }

    override var canBecomeMain: Bool {
        return true
    }
    
    private func setupRoundedCorners() {
        // Set the window to have rounded corners
        self.contentView?.wantsLayer = true
        self.contentView?.layer?.cornerRadius = 10
        self.contentView?.layer?.masksToBounds = true
        
        // Set the window background to be clear to see through the NSVisualEffectView
        self.backgroundColor = NSColor.clear
    }
}
