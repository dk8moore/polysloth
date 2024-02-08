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
        // Setup transparent and blurry effect for the window
        setupVisualEffectView()
        // Customize the shape and appearance of the window
        setupRoundedCorners()
    }
    
    override var canBecomeKey: Bool {
        return true
    }

    override var canBecomeMain: Bool {
        return true
    }

    private func setupVisualEffectView() {
        // Set up the visual effect view to blur and tint the background.
        effectView = NSVisualEffectView(frame: self.contentView?.bounds ?? NSRect())
        effectView.blendingMode = .behindWindow
        effectView.state = .active
        effectView.material = .hudWindow // or .popover, .sidebar, .menu, etc., depending on the desired effect
        effectView.wantsLayer = true
        effectView.layer?.cornerRadius = 10
        effectView.layer?.masksToBounds = true

        self.contentView?.addSubview(effectView)
        
        // Ensure the effect view resizes with the window
        effectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            effectView.topAnchor.constraint(equalTo: self.contentView!.topAnchor),
            effectView.leftAnchor.constraint(equalTo: self.contentView!.leftAnchor),
            effectView.rightAnchor.constraint(equalTo: self.contentView!.rightAnchor),
            effectView.bottomAnchor.constraint(equalTo: self.contentView!.bottomAnchor),
        ])
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
