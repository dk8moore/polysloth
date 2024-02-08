//
//  MainApplication.swift
//  polysloth
//
//  Created by Denis Ronchese on 07/02/24.
//

import Cocoa

class MainApplication: NSApplication {
    override init() {
        super.init()
        self.delegate = AppDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func run() {
        self.delegate?.applicationWillFinishLaunching?(Notification(name: Notification.Name("WillFinishLaunching")))
        self.delegate?.applicationDidFinishLaunching?(Notification(name: Notification.Name("DidFinishLaunching")))
        self.finishLaunching()
        super.run()
    }
}

